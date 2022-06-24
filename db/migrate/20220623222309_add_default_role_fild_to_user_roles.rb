class AddDefaultRoleFildToUserRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles, :default_role, :boolean, default: false
    add_column :user_roles, :active, :boolean, default: true
  end
end
