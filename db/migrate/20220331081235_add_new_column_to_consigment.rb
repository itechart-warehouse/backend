class AddNewColumnToConsigment < ActiveRecord::Migration[5.2]
  def change
    add_column :consignments, :checked_date, :string, default: 'N/A'
    add_column :consignments, :checked_user_id, :integer
    add_column :consignments, :placed_date, :string, default: 'N/A'
    add_column :consignments, :placed_user_id, :integer
  end
end
