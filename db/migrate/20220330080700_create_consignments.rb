class CreateConsignments < ActiveRecord::Migration[5.2]
  def change
    create_table :consignments do |t|
      t.string :status
      t.string :bundle_seria
      t.string :bundle_number
      t.string :consignment_seria
      t.string :consignment_number
      t.string :truck_number
      t.string :first_name
      t.string :second_name
      t.string :passport
      t.string :contractor_name
      t.integer :user_id
      t.string :date
      t.timestamps
    end
  end
end
