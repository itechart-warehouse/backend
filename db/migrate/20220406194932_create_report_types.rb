class CreateReportTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :report_types do |t|
      t.string :type
      t.timestamps
    end
  end
end
