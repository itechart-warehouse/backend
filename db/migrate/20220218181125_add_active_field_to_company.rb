class AddActiveFieldToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :active, :boolean, default: true
  end
end
