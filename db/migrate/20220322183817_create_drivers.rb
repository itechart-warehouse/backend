class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :first_name
      t.string :last_name
      t.string :passport_number
      t.string :passport_info
      t.integer :contractor_id
      t.timestamps
    end
  end
end

