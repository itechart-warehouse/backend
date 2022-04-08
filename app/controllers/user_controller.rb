# frozen_string_literal: true

class UserController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper
  load_and_authorize_resource

  def index
    user_initialize_index
    json = []
    @users.each do |user|
      json << {
        user: user,
        company: user.company
      }
    end
    render json: { users: json }, status: :ok
  end

  def show
    user = User.find(params[:id])
    company = user.company
    role = user.user_role
    render json: { user: user, company: company, role: role }, status: :ok
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: { user: user }, status: :ok
    else
      render json: { user_errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    user = User.new(user_params)
    company = Company.find_by(company_params)
    company.users << user
    Warehouse.find(@current_user.warehouse_id).users << user 
    if user.save
      render json: { user: user }, status: :created
    else
      render json: { user_errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def company_and_roles_list
    roles = UserRole.all
    companies = Company.all
    render json: { companies: companies, roles: roles }, status: :ok
  end

  def user_initialize_index
    case @ability_lvl
    when 'system'
      @users = User.all
    when 'company'
      @users = Company.find(@current_user.company_id).users
    when 'warehouse'
      @users = Warehouse.find(@current_user.warehouse_id).users
    end
  end

  private

  def company_params
    params.require(:company).permit(:id)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birth_date, :address, :company_id,
                                 :user_role_id, :active)
  end
end
