# frozen_string_literal: true

class UserController < ApplicationController
  respond_to :json
  load_and_authorize_resource

  def index
    user_initialize_index
    json = []
    @users.each do |user|
      json << {
        user: user,
        company: user.company,
        role: user.user_role.name
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
    Company.find(@current_user.company_id).users << user
    Warehouse.find(@current_user.warehouse_id).users << user
    if user.save
      render json: { user: user }, status: :created
    else
      render json: { user_errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def company_and_roles_list
    roles = UserRole.all
    role = []
    roles.each do |rol|
      role << rol if rol.id > 4
    end
    render json: { roles: role }, status: :ok
  end

  def user_initialize_index
    case @ability_lvl
    when UserRole::ABILITY_SYSTEM
      @users = User.all
    when UserRole::ABILITY_COMPANY
      @users = Company.find(@current_user.company_id).users
    when UserRole::ABILITY_WAREHOUSE
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
