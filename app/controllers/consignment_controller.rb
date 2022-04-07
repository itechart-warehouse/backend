# frozen_string_literal: true

class ConsignmentController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper
  # load_and_authorize_resource

  def index
    consignments = Consignment.all
    if @ability_lvl== 'system'
      consignments = Consignment.all
    else
      consignments = @current_user.company.consignments
    end
    reports = []
    consignment.reports.each do |report|
      reports << {
        report: report,
        report_type: report.report_type.name
      }
      end
    render json: { consignments: consignments, reports: reports }, status: :ok
  end

  def show
    consignment = Consignment.find(params[:id])
    reports = []
    consignment.reports.each do |report|
      reports << {
        report: report,
        report_type: report.report_type.name
      }
    end
    render json: { consignment: consignment, actions: { user: User.find(consignment.user_id) }, reports: reports }, status: :ok
  end

  def create
    consignment = Consignment.new(consignment_params)
    consignment.update(date: Time.new, user_id: @current_user.id, status: 'Registered', company_id: @current_user.company_id)
    goods = goods_params
    if consignment.save
      goods.each do |good|
        Good.create(name: good[:good_name], quantity: good[:quantity], status: 'Registered',
                     bundle_seria: consignment.bundle_seria, bundle_number: consignment.bundle_number,
                     date: Time.new, consignment_id: consignment.id)
      end
      goods = Good.where(consignment_id: consignment.id)
      render json: { consignment: consignment, goods: goods }, status: :created
    else
      render json: { consignment_errors: consignment.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def check
    consignment = Consignment.find(params[:id])
    if consignment.status == 'Placed'
      render json: { error: 'This consignment is placed' }, status: 402
    elsif !@current_user.warehouse_id.nil?
      consignment.update(checked_date: Time.new, checked_user_id: @current_user.id, status: 'Checked')
      goods = consignment.goods
      goods.each do |good|
        if good.status == 'Registered'
          good.update(checked_date: Time.new, checked_user_id: @current_user.id, status: 'Checked')
        end
      end
      render json: { consignment: consignment }, status: :ok
    else
      render json: { error: 'No warehouse' }, status: 402
    end
  end

  def place
    consignment = Consignment.find(params[:id])
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
      render json: { error: 'You must check the consignment before placing in the warehouse.' }, status: 402
    end
  end

  def place_goods(consignment)
    goods = consignment.goods
    goods_area = 0
    goods.each do |good|
      goods_area += good.quantity.to_i
    end
    if !@current_user.warehouse_id.nil?
      warehouse = Warehouse.find(@current_user.warehouse_id)
      if warehouse.area.to_i - warehouse.reserved.to_i >= goods_area
        warehouse.update(reserved: goods_area + warehouse.reserved.to_i)
      else
        render json: { error: 'No area' }, status: 402
        false
      end
    else
      render json: { error: 'No warehouse' }, status: 402
      false
    end
  end

  def recheck
    consignment = Consignment.find(params[:id])
    if consignment.status != 'Placed'
      render json: { error: 'This consignment must be placed' }, status: 402
    elsif !@current_user.warehouse_id.nil?
      consignment.update(rechecked_date: Time.new, rechecked_user_id: @current_user.id,
                         status: 'Checked before shipment')
      goods = consignment.goods
      goods.each do |good|
        if good.status == 'Placed'
          good.update(rechecked_date: Time.new, rechecked_user_id: @current_user.id, status: 'Checked before shipment')
        end
      end
      render json: { consignment: consignment }, status: :ok
    else
      render json: { error: 'No warehouse' }, status: 402
    end
  end

  def shipp
    consignment = Consignment.find(params[:id])
    if consignment.status == 'Checked before shipment'
      if shipp_goods(consignment)
        consignment.update(placed_date: Time.new, placed_user_id: @current_user.id, status: 'Shipped',
                           warehouse_id: nil)
        goods = consignment.goods
        goods.each do |good|
          if good.status == 'Checked before shipment'
            good.update(placed_date: Time.new, placed_user_id: @current_user.id, status: 'Shipped', warehouse_id: nil)
          end
        end
        render json: { consignment: consignment }, status: :ok
      end
    else
      render json: { error: 'You must recheck the consignment before shipped of the warehouse.' }, status: 402
    end
  end

  def shipp_goods(consignment)
    goods = consignment.goods
    goods_area = 0
    goods.each do |good|
      goods_area += good.quantity.to_i
    end
    if @current_user.warehouse_id == consignment.warehouse_id
      warehouse = Warehouse.find(@current_user.warehouse_id)
      warehouse.update(reserved: warehouse.reserved.to_i - goods_area)
    else
      render json: { error: 'This is not consignment from your warehouse! ' }, status: 402
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
