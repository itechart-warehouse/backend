class CreateWarehouses < ActiveRecord::Migration[5.2]
  def change
    create_table :warehouses do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :area
      t.integer :company_id
      t.timestamps
      end
    end
  end
