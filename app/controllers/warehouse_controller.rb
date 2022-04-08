# frozen_string_literal: true

class WarehouseController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper
  load_and_authorize_resource

  def index
    if @ability_lvl== 'system'
      warehouses = Warehouse.where(company_id: params[:company_id])
      company = Company.find(params[:company_id])
    elsif @ability_lvl== 'company'
      warehouses = Warehouse.where(company_id: @current_user.company_id)
      company = Company.find(@current_user.company_id)
    else
      warehouses = Warehouse.find(@current_user.warehouse_id)
      company = Company.find(@current_user.company_id)
    end
    json = []
    warehouses.each do |warehouse|
      json << {
        warehouse: warehouse,
        user: warehouse.users.where(user_role_id: UserRole.find_role_by_name('Warehouse admin').id)
      }
    end
    render json: { warehouses: json, company: company }, status: :ok
  end

  def show
    warehouse = Warehouse.find(params[:id])
    company = warehouse.company
    user = warehouse.users.find_by(user_role_id: UserRole.find_role_by_name('Warehouse admin'))
    render json: { warehouse: warehouse, company: company, user: user }, status: :ok
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
      render json: { warehouse: warehouse, sections: warehouse.sections, admin: user }, status: :created
    else
      render json: { warehouse_errors: warehouse.errors.full_messages, user_errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    warehouse = Warehouse.find(params[:id])
    if warehouse.update(warehouse_params)
      render json: { warehouse: warehouse }, status: :ok
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
