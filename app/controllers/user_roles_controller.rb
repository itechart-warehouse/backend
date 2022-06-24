# frozen_string_literal: true

class UserRolesController < ApplicationController
  respond_to :json
  load_and_authorize_resource
  before_action :role, only: %i[show update destroy users_by_role]

  def index
    @roles= []
    case @ability_lvl
    when UserRole::ABILITY_SYSTEM
      UserRole.all.each {|role| role_comparator(role)}
    when UserRole::ABILITY_COMPANY
      UserRole.all.each { |role| role_comparator(role) if role.company_id==@current_user.company_id || role.company_id==nil}
    end
      render json: { roles: @roles}, status: :ok
  end

  def show
    render json: @role
  end

  def destroy
    if !@role.default_role?
      @role.update(active: false)
      render json: {role: @role}, status: :ok
    end
  end

  def create
    role = UserRole.new(user_role_params)
    if role.save
      render json: { role: role }, status: :ok
    else
      render json: { errors: role.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @role.update(user_role_params)
      render json: @role
    else
      render json: { user_errors: @role.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def users_by_role
    users, meta = paginate_collection(User.where(user_role_id: @role.id))
    render json: {users: users, users_count: meta[:total_count]}
  end

  private

  def role_comparator(role)
    if role.company_id!=nil
      @company = Company.find(@current_user.company_id).name
    else
      @company = "Default role"
    end
    @roles << [
      role, @company
    ]
  end

  def role
    @role ||= UserRole.find(params[:id])
  end

  def user_role_params
    params.require(:user_role).permit(:id, :name, :code, :company_id, :manage_all,
                                      :manage_all_users, :manage_all_warehouses, :manage_all_companys,
                                      :manage_all_consigments, :manage_all_roles, :read_all,
                                      :read_all_user, :read_all_warehouse, :read_all_company,
                                      :read_all_consigment, :read_all_roles, :manage_your_company_user,
                                      :manage_your_company_warehouses, :manage_your_company,
                                      :manage_your_warehouse, :manage_your_company_consigment,
                                      :manage_your_company_roles, :read_your_company_user,
                                      :read_your_company_warehouse, :read_your_company_consigment,
                                      :reg_consigment, :check_consigment, :place_consigment)
  end
end
