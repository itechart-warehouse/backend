class CreateSections < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
      t.string :name
      t.string :area
      t.integer :warehouse_id
      t.timestamps
    end
  end
end
