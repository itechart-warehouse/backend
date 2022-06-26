class AddCompanyNameToUserRole < ActiveRecord::Migration[5.2]
  def change
    add_column :user_roles, :company_name, :string
  end
end
