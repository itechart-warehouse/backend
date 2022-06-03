# frozen_string_literal: true

class WarehouseController < ApplicationController
  respond_to :json
  load_and_authorize_resource

  def index
    warehouses_data = case @ability_lvl
                      when UserRole::ABILITY_SYSTEM
                        paginate_collection(Warehouse.where(company_id: params[:company_id]))
                      when UserRole::ABILITY_COMPANY
                        paginate_collection(Warehouse.where(company_id: @current_user.company_id))
                      else
                        paginate_collection(Warehouse.find(@current_user.warehouse_id))
                      end
    render json: { warehouses: warehouses_data[0].to_json(include: [users: { only: %i[first_name last_name] }, company: { only: :name }]),
                   warehouses_count: warehouses_data[1][:total_count] }
  end

  def show
    warehouse = Warehouse.find(params[:id])
    render json: warehouse
  end

  def create
    company = Company.find_by(company_params)
    warehouse = Warehouse.new(warehouse_params)
    warehouse.company_id = company.id
    user = User.new(user_params)
    user.update(company_id: company.id, user_role_id: UserRole.find_role_by_name('Warehouse admin').id)
    if warehouse.valid? && user.valid?
      company.users << user
      company.warehouses << warehouse
      warehouse.users << user
      render json: { warehouse: warehouse, admin: user }
    else
      render json: { warehouse_errors: warehouse.errors.full_messages, user_errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    warehouse = Warehouse.find(params[:id])
    if warehouse.update(warehouse_params)
      render json: warehouse
    else
      render json: { warehouse_errors: warehouse.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :address, :phone, :area, :company_id, :active)
  end

  def company_params
    params.require(:company).permit(:id)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birth_date, :address)
  end
end
