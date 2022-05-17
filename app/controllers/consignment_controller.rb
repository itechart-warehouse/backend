# frozen_string_literal: true

class ConsignmentController < ApplicationController
  respond_to :json
  load_and_authorize_resource

  def index
    consignments = ability_system? ? Consignment.all : @current_user.company.consignments
    consignments.each { |consignment| consignment.reports.each { |_report| consignment.update(reported: true) } }
    render json: { consignments: consignments }, status: :ok
  end

  def show
    consignment = Consignment.find(params[:id])
    consignment.reports.each { |_report| consignment.update(reported: true) }
    user = case consignment.status
           when 'Registered'
             User.find(consignment.user_id)
           when 'Checked'
             User.find(consignment.checked_user_id)
           when 'Placed'
             User.find(consignment.placed_user_id)
           when 'Checked before shipment'
             User.find(consignment.rechecked_user_id)
           when 'Shipped'
             User.find(consignment.shipped_user_id)
           end
    render json: { consignment: consignment, actions: { user: user } }, status: :ok
  end

  def create
    consignment = Consignment.new(consignment_params)
    consignment.update(date: Time.new, user_id: @current_user.id, status: 'Registered',
                       company_id: @current_user.company_id)
    goods = goods_params
    if consignment.save
      goods.each do |good|
        Good.create(name: good[:good_name], quantity: good[:quantity], status: 'Registered',
                    bundle_seria: consignment.bundle_seria, bundle_number: consignment.bundle_number,
                    date: Time.new, consignment_id: consignment.id, company_id: consignment.company_id)
      end
      goods = Good.where(consignment_id: consignment.id)
      render json: { consignment: consignment, goods: goods }, status: :created
    else
      render json: { consignment_errors: consignment.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def check
    consignment = Consignment.find(params[:consignment_id])
    if consignment.status == 'Placed'
      render json: { error: (I18n.t :c_is_placed) }, status: 402
    elsif !@current_user.warehouse_id.nil?
      consignment.update(checked_date: Time.new, checked_user_id: @current_user.id, status: 'Checked')
      goods = consignment.goods
      goods.each do |good|
        good.update(checked_date: Time.new, checked_user_id: @current_user.id, status: 'Checked') if good.status == 'Registered'
      end
      render json: { consignment: consignment }, status: :ok
    else
      render json: { error: (I18n.t :no_warehouse) }, status: 402
    end
  end

  def place
    consignment = Consignment.find(params[:consignment_id])
    if consignment.status == 'Checked'
      if place_goods(consignment)
        consignment.update(placed_date: Time.new, placed_user_id: @current_user.id, status: 'Placed',
                           warehouse_id: @current_user.warehouse_id)
        goods = consignment.goods
        goods.each do |good|
          if good.status == 'Checked'
            good.update(placed_date: Time.new, placed_user_id: @current_user.id, status: 'Placed',
                        warehouse_id: @current_user.warehouse_id)
          end
        end
        render json: { consignment: consignment }, status: :ok
      end
    else
      render json: { error: (I18n.t :y_must_check) }, status: 402
    end
  end

  def place_goods(consignment)
    goods = consignment.goods
    goods_area = 0
    reported_area = 0
    goods.each do |good|
      goods_area += good.quantity.to_i
      next if good.reported_goods.nil?

      good.reported_goods.each do |report|
        reported_area += report.reported_quantity.to_i
      end
    end
    if !@current_user.warehouse_id.nil?
      warehouse = Warehouse.find(@current_user.warehouse_id)
      if warehouse.area.to_i - warehouse.reserved.to_i >= goods_area
        warehouse.update(reserved: goods_area + warehouse.reserved.to_i - reported_area)
      else
        render json: { error: (I18n.t :no_area) }, status: 402
        false
      end
    else
      render json: { error: (I18n.t :no_warehouse) }, status: 402
      false
    end
  end

  def recheck
    consignment = Consignment.find(params[:consignment_id])
    if consignment.status != 'Placed'
      render json: { error: (I18n.t :must_placed) }, status: 402
    elsif !@current_user.warehouse_id.nil?
      consignment.update(rechecked_date: Time.new, rechecked_user_id: @current_user.id,
                         status: 'Checked before shipment')
      goods = consignment.goods
      goods.each do |good|
        good.update(rechecked_date: Time.new, rechecked_user_id: @current_user.id, status: 'Checked before shipment') if good.status == 'Placed'
      end
      render json: { consignment: consignment }, status: :ok
    else
      render json: { error: (I18n.t :no_warehouse) }, status: 402
    end
  end

  def shipp
    consignment = Consignment.find(params[:consignment_id])
    if consignment.status == 'Checked before shipment'
      if shipp_goods(consignment)
        consignment.update(shipped_date: Time.new, shipped_user_id: @current_user.id, status: 'Shipped',
                           warehouse_id: nil)
        goods = consignment.goods
        goods.each do |good|
          good.update(shipped_date: Time.new, shipped_user_id: @current_user.id, status: 'Shipped', warehouse_id: nil) if good.status == 'Checked before shipment'
        end
        render json: { consignment: consignment }, status: :ok
      end
    else
      render json: { error: (I18n.t :y_must_recheck) }, status: 402
    end
  end

  def shipp_goods(consignment)
    goods = consignment.goods
    goods_area = 0
    reported_area = 0
    goods.each do |good|
      next if good.reported_goods.nil?

      good.reported_goods.each do |report|
        reported_area += report.reported_quantity.to_i
      end
      goods_area += good.quantity.to_i
    end
    if @current_user.warehouse_id == consignment.warehouse_id
      warehouse = Warehouse.find(@current_user.warehouse_id)
      warehouse.update(reserved: warehouse.reserved.to_i - goods_area + reported_area)
    else
      render json: { error: (I18n.t :not_your_cons) }, status: 402
      false
    end
  end

  private

  def consignment_params
    params.require(:consignment).permit(:status, :id,
                                        :bundle_seria,
                                        :bundle_number,
                                        :consignment_seria,
                                        :consignment_number,
                                        :truck_number,
                                        :first_name,
                                        :second_name,
                                        :middle_name,
                                        :passport,
                                        :contractor_name)
  end

  def goods_params
    params.require(:goods)
  end
end
