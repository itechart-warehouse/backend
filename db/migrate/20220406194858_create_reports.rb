class CreateReports < ActiveRecord::Migration[5.2]
  def change
    create_table :reports do |t|
      t.string :report_date
      t.string :description
      t.integer :report_type_id
      t.integer :user_id
      t.timestamps
    end
  end
end
