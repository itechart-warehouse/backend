# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    preinitialize(current_user)
    standart_ability(current_user)
    if @company.active? || @role == 1
      case @role
      when 1 # System Admin ability
        system_admin_ability
      when 2# Company owner ability
        company_owner_ability
      when 3 # Company admin ability
        company_admin_ability
      when 4 # Warehouse admin ability
        warehouse_admin_ability
      when 5 # Dispatcher ability
        dispatcher_ability
      when 6 # Inspector ability
        inspector_ability
      when 7 # Warehouse Manager ability
        warehouse_manager_ability
      end
    end
  end

  def standart_ability(current_user)
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
  end

  def preinitialize(current_user)
    @warehouse = []
    @user = current_user
    @role = current_user.user_role_id
    @company = Company.find(current_user.company_id)
    @users = @company.users
    @warehouses = @company.warehouses
    @consignments = @company.consignments
    @reports = @company.reports
    @goods = @company.goods
    if current_user.warehouse_id !=nil
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
  end

  def admin_ability
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
