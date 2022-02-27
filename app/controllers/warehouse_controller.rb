class WarehouseController < ApplicationController
  respond_to :json

  def index
    warehouses = Warehouse.where(company_id: params[:company_id])

    render json: { warehouses: warehouses }, status: :ok
  end
end