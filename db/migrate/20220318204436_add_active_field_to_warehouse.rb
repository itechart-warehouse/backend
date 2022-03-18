class AddActiveFieldToWarehouse < ActiveRecord::Migration[5.2]
  def change
    add_column :warehouses, :active, :boolean, default: true
  end
end
