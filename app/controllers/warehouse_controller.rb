class WarehouseController < ApplicationController
  respond_to :json

  def index
    warehouses = Warehouse.all
    render json: { warehouses: warehouses }, status: :ok
  end
end