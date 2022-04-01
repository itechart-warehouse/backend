class AddNewColumnToGoods < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :checked_date, :string, default: 'N/A' 
    add_column :goods, :checked_user_id, :integer
    add_column :goods, :placed_date, :string, default: 'N/A'
    add_column :goods, :placed_user_id, :integer
  end
end
