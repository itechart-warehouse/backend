class AddReservedFieldToWarehouse < ActiveRecord::Migration[5.2]
  def change
    add_column :warehouses, :reserved, :string, default: '0'
  end
end
