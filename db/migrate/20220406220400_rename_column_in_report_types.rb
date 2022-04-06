class RenameColumnInReportTypes < ActiveRecord::Migration[5.2]
  def change
    remove_column :report_types, :type
    add_column :report_types, :name, :string
  end
end
