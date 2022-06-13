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
      when UserRole::COMPANY_OWNER # Company owner ability
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
      custom_role_ability(current_user)
    end
  end

  def valid
    if @role == UserRole::SYSTEM_ADMIN
      true
    elsif @company.active? && @user.active?
      true
    else
      false
    end
  end

  def standart_ability(_current_user)
    can :read, @user
    can :read, @company
    can :read, @warehouse
    can :read, UserRole
    can :read, Consignment
    can :manage, @reports
    can :manage, @goods
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
    @user_roles = UserRole.where(company_id: current_user.company_id)
    unless current_user.warehouse_id.nil?
      @warehouse = Warehouse.find(current_user.warehouse_id)
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

  def custom_role_ability
    manage_ability
    read_ability
    custom_ability
  end

  def manage_ability
    can :manage, All if @role.manage_all
    can :manage, User if @role.manage_all_users
    can :manage, UserRole if @role.manage_all_roles
    can :manage, Company if @role.manage_all_companys
    if @role.manage_all_warehouses
      can :manage, Warehouse
      can :read, Company
    end
    if @role.manage_all_consigments
      can :manage, Consignment
      can :read, Report
      can :read, Warehouse
      can :read, Goods
    end
    can :manage, @company if @role.manage_your_company
    can :manage, @company.users if @role.manage_your_company_user
    can :manage, @user_roles if @role.manage_your_company_roles
    can :manage, @warehouse if @role.manage_your_warehouse
    can :manage, @warehouses if @role.manage_your_company_warehouses
    can :manage, @company.consignments if @role.manage_your_company_consigment
  end

  def read_ability
    can :read, All if @role.read_all
    can :read, User if @role.read_all_user
    can :read, UserRole if @role.read_all_roles
    can :read, Company if @role.read_all_company
    if @role.read_all_warehouse
      can :read, Warehouse
      can :read, Company
    end
    if @role.read_all_consigment
      can :read, Consignment
      can :read, Warehouse
    end
    can :read, @company.users if @role.read_your_company_user
    can :read, @warehouses if @role.read_your_company_warehouse
    can :read, @company.consignments if @role.read_your_company_consigment
  end

  def custom_ability
    if @role.reg_consigment
      can :create, Consignment
      can :shipp, @consignments
    end
    if @role.check_consigment
      can :check, @consignments
      can :recheck, @consignments
    end
    can :place, @consignments if @role.place_consigment
  end
end
