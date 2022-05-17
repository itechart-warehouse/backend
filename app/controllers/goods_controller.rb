# frozen_string_literal: true

class GoodsController < ApplicationController
  respond_to :json
  #  load_and_authorize_resource

  def index
    consignment = Consignment.find(params[:consignment_id])
    goods = consignment.goods
    render json: { goods: goods, consignment: consignment,
                   warehouse: consignment.warehouse_id ? Warehouse.find(consignment.warehouse_id) : '' }
  end
end
