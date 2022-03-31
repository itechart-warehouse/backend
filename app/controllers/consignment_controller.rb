# frozen_string_literal: true

class ConsignmentController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper
  # load_and_authorize_resource

  def index
    consignments = Consignment.all
    render json: { consignments: consignments }, status: :ok
  end

  def show
    consignment = Consignment.find(params[:id])
    render json: { consignment: consignment, actions: { user: User.find(consignment.user_id) } }, status: :ok
  end

  def create
    consignment = Consignment.new(consignment_params)
    consignment.update(date: Time.new, user_id: @current_user.id, status: 'Registered')
    goods = goods_params
    if consignment.save
      goods.each do |good|
        Goods.create(name: good[:good_name], quantity: good[:quantity], status: good[:status],
                     bundle_seria: consignment.bundle_seria, bundle_number: consignment.bundle_number,
                     date: Time.new, consignment_id: consignment.id)
      end
      goods = Goods.where(consignment_id: consignment.id)
      render json: { consignment: consignment, goods: goods }, status: :created
    else
      render json: { consignment_errors: consignment.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def check
    consignment = Consignment.find(params[:id])
    consignment.update(checked_date: Time.new, checked_user_id: @current_user.id, status: 'Checked')
    goods = Goods.where(consignment_id: consignment.id)
    goods.each do |good|
      good.update(checked_date: Time.new, checked_user_id: @current_user.id, status: 'Checked')
    end
    render json: { consignment: consignment }, status: :ok
  end

  def place
    consignment = Consignment.find(params[:id])
    if consignment.status == 'Checked'
      if place_goods(consignment)
        consignment.update(placed_date: Time.new, placed_user_id: @current_user.id, status: 'Placed')
        goods = Goods.where(consignment_id: consignment.id)
        goods.each do |good|
          good.update(placed_date: Time.new, placed_user_id: @current_user.id, status: 'Placed')
        end
        render json: { consignment: consignment }, status: :ok
      end
    else
      render json: { error: 'You must check the consignment before placing in the warehouse.' }, status: 402
    end
  end

  def place_goods(consignment)
    goods = Goods.where(consignment_id: consignment.id)
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
