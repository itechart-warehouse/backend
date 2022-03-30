class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.string :name
      t.string :quantity
      t.string :status
      t.string :bundle_seria
      t.string :bundle_number
      t.string :date
      t.string :consignment_id
      t.timestamps
    end
  end
end
