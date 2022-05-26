# frozen_string_literal: true

class UserController < ApplicationController
  respond_to :json
  load_and_authorize_resource
  before_action :user_initialize_index, only: :index
  before_action :user, only: %i[show update]

  def index
    render json: { users: @users.to_json(include: [company: { only: :name }, user_role: { only: :name }]), users_count: User.count }
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { user_errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def create
    user = User.new(user_params)
    Company.find(@current_user.company_id).users << user
    Warehouse.find(@current_user.warehouse_id).users << user
    if user.save
      render json: user
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
    page = params.fetch(:page, 0).to_i * default_page_size
    case @ability_lvl
    when UserRole::ABILITY_SYSTEM
      @users = User.all.offset(page).limit(default_page_size)
    when UserRole::ABILITY_COMPANY
      @users = Company.find(@current_user.company_id).users.offset(page).limit(default_page_size)
    when UserRole::ABILITY_WAREHOUSE
      @users = Warehouse.find(@current_user.warehouse_id).users.offset(page).limit(default_page_size)
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:id)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birth_date, :address, :company_id,
                                 :user_role_id, :active)
  end
end
