# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    preinitialize(current_user)
    cannot :login, :all
    if valid
      standart_ability(current_user)
      case @role
      when UserRole::SYSTEM_ADMIN # System Admin ability
        system_admin_ability
      when UserRole::COMPANY_OWNER# Company owner ability
        company_owner_ability
      when UserRole::COMPANY_ADMIN # Company admin ability
        company_admin_ability
      when UserRole::WAREHOUSE_ADMIN # Warehouse admin ability
        warehouse_admin_ability
      when UserRole::DISPATCHER # Dispatcher ability
        dispatcher_ability
      when UserRole::INSPECTOR # Inspector ability
        inspector_ability
      when UserRole::MANAGER # Warehouse Manager ability
        warehouse_manager_ability
      end
    end
  end

  def valid
    if @role == UserRole::SYSTEM_ADMIN
      true
    elsif  @company.active? && @user.active?
      true
    else
      false
    end
  end

  def standart_ability(current_user)
    can :page ,User
    can :page ,Consignment
    can :read , @user
    can :read , @company
    can :read , @warehouse
    can :read , :user_roles
    can :read, UserRole
    can :read, Consignment
    can :manage, @reports
    can :manage, @goods
    cannot :check, @consignments
    can :create, Report
    can :index_where_consigment_id, Report
    can :show_reported, Report
  end

  def preinitialize(current_user)
    @warehouse = []
    @user = current_user
    @role = UserRole.find(current_user.user_role_id).name
    @company = Company.find(current_user.company_id)
    @users = @company.users
    @warehouses = @company.warehouses
    @consignments = @company.consignments
    @reports = @company.reports
    @goods = @company.goods
    if current_user.warehouse_id !=nil
      @warehouse = Warehouse.find(current_user.warehouse_id)
      @warehouses = Warehouse.find(current_user.warehouse_id)
      @users = @warehouses.users
    end
  end


  def system_admin_ability
    can :manage, :all
  end

  def company_owner_ability
    admin_ability
    can :manage, @company
  end

  def company_admin_ability
    admin_ability
    can :manage, @company
  end

  def warehouse_admin_ability
    admin_ability
    can :create, User
    cannot :create, Warehouse
  end

  def admin_ability
    can :index, Warehouse
    can :create, Warehouse
    can :index, Company
    cannot :create, Report
    can :index, User
    can :company_and_roles_list, :all
    can :manage, @users
    can :manage, @warehouses
    can :manage, @consignments
    can :create, Consignment
  end

  def dispatcher_ability
    can :create, Consignment
    can :shipp, @consignments
  end

  def inspector_ability
    can :check, @consignments
    can :recheck, @consignments
  end

  def warehouse_manager_ability
    can :place, @consignments
  end
end
