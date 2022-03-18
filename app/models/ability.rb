# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(current_user)
    preinitialize(current_user)
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
        can :read, :user
      when 6 # Inspector ability
        can :read, :user
      when 7 # Warehouse Manager ability
        can :read, :user
      end
    end
  end

  def preinitialize(current_user)
    @role = current_user.user_role_id
    @company = Company.find(current_user.company_id)
    @users = @company.users
    @warehouses = @company.warehouses
    if current_user.warehouse_id !=nil
      @warehouse = Warehouse.find(current_user.warehouse_id)
      @warehouse_users = @warehouse.users
      @warehouse_sections = @warehouse.sections
    end
  end

  def system_admin_ability
    can :manage, :all
  end

  def company_owner_ability
    can :index, User
    can :read, UserRole
    can :index, Company
    can :company_and_roles_list, :all
    can :manage, @company
    can :manage, @users
    can :manage, @warehouses
  end

  def company_admin_ability
    can :index, User
    can :read, UserRole
    can :index, Company
    can :company_and_roles_list, :all
    can :manage, @company
    can :manage, @users
    can :manage, @warehouses
  end

  def warehouse_admin_ability
    can :index, User
    can :read, UserRole
    can :index, Company
    can :company_and_roles_list, :all
    can :read, @company
    can :manage, @users
    can :manage, @warehouse
  end
end
