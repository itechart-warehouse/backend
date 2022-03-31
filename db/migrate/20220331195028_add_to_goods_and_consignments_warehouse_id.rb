class AddToGoodsAndConsignmentsWarehouseId < ActiveRecord::Migration[5.2]
  def change
    add_column :consignments, :warehouse_id, :integer
    add_column :goods, :warehouse_id, :integer
  end
end
