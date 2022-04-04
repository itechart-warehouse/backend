class AddNewStatusAndAnotherToConsignmentsAndGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :rechecked_date, :string, default: 'N/A'
    add_column :goods, :rechecked_user_id, :integer
    add_column :goods, :shipped_date, :string, default: 'N/A'
    add_column :goods, :shipped_user_id, :integer
    add_column :consignments, :rechecked_date, :string, default: 'N/A'
    add_column :consignments, :rechecked_user_id, :integer
    add_column :consignments, :shipped_date, :string, default: 'N/A'
    add_column :consignments, :shipped_user_id, :integer
  end
end
