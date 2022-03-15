# frozen_string_literal: true

class WarehouseController < ApplicationController
  respond_to :json

  def index
    warehouses = Warehouse.where(company_id: params[:company_id])
    json = []
    company = Company.find(params[:company_id])
    warehouses.each do |warehouse|
      json << {
        warehouse: warehouse,
        user: warehouse.users.where(user_role_id: UserRole.find_role_by_name('Warehouse admin').id )
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
    user.update(company_id: company.id, user_role_id: UserRole.find_role_by_name('Warehouse admin').id )
    if warehouse.valid? && user.valid?
      company.users << user
      company.warehouses << warehouse
      warehouse.users << user
      create_default_sections(warehouse)
      render json: { warehouse: warehouse, sections: warehouse.sections, admin: user }, status: :created
    else
      render json: { warehouse_errors: warehouse.errors, user_errors: user.errors }, status: :unprocessable_entity
    end
  end

  def create_default_sections(warehouse)
    basic_area = warehouse.area.to_i / 2
    id = warehouse.id
    Section.create(name: 'Type1', area: basic_area, warehouse_id: id)
    Section.create(name: 'Type2', area: basic_area, warehouse_id: id)
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :address, :phone, :area, :company_id)
  end

  def company_params
    params.require(:company).permit(:id)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birth_date, :address)
  end
end
