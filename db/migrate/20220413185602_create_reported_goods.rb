class CreateReportedGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :reported_goods do |t|
      t.string :name
      t.string :reported_quantity
      t.string :quantity
      t.string :status
      t.string :bundle_seria
      t.string :bundle_number
      t.string :date
      t.integer :consignment_id
      t.integer :report_id
      t.integer :good_id
    end
  end
end
