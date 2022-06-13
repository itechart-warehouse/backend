class UserRoleUpdate < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles, :manage_all, :boolean, default: false
    add_column :user_roles, :manage_all_users, :boolean, default: false
    add_column :user_roles, :manage_all_warehouses, :boolean, default: false
    add_column :user_roles, :manage_all_companys, :boolean, default: false
    add_column :user_roles, :manage_all_consigments, :boolean, default: false
    add_column :user_roles, :manage_all_roles, :boolean, default: false
    add_column :user_roles, :read_all, :boolean, default: false
    add_column :user_roles, :read_all_user, :boolean, default: false
    add_column :user_roles, :read_all_warehouse, :boolean, default: false
    add_column :user_roles, :read_all_company, :boolean, default: false
    add_column :user_roles, :read_all_consigment, :boolean, default: false
    add_column :user_roles, :read_all_roles, :boolean, default: false
    add_column :user_roles, :manage_your_company_user, :boolean, default: false
    add_column :user_roles, :manage_your_company_warehouses, :boolean, default: false
    add_column :user_roles, :manage_your_company, :boolean, default: false
    add_column :user_roles, :manage_your_warehouse, :boolean, default: false
    add_column :user_roles, :manage_your_company_consigment, :boolean, default: false
    add_column :user_roles, :manage_your_company_roles, :boolean, default: false
    add_column :user_roles, :read_your_company_user, :boolean, default: false
    add_column :user_roles, :read_your_company_warehouse, :boolean, default: false
    add_column :user_roles, :read_your_company_consigment, :boolean, default: false
    add_column :user_roles, :reg_consigment, :boolean, default: false
    add_column :user_roles, :check_consigment, :boolean, default: false
    add_column :user_roles, :place_consigment, :boolean, default: false
    add_column :user_roles, :company_id, :integer
  end
end
