class UpdateConsignmentIdInGoods < ActiveRecord::Migration[5.2]
  def change
    remove_column :goods, :consignment_id
    add_column :goods, :consignment_id, :integer
  end
end
