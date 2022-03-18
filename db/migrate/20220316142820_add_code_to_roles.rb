class AddCodeToRoles < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles, :code, :string
  end
end
