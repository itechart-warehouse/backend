# frozen_string_literal: true

class GoodsController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper

  def index
    consignment = Consignment.find(params[:id])
    goods = consignment.goods
    render json: { goods: goods, consignment: consignment, warehouse: consignment.warehouse_id ? Warehouse.find(consignment.warehouse_id) : '' }
  end

end
