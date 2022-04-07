class AddConsignmentIdToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :consignment_id, :integer
  end
end
