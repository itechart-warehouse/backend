class AddToUserWarehouseId < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :warehouse_id, :integer
  end
end
