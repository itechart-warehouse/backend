class AddUserRoleIdInUserfix < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_role_id, :integer
  end
end
