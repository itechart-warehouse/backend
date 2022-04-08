class AddNewColumnToConsginmentsReportOrNotAndToReportsCompanyId < ActiveRecord::Migration[5.2]
  def change
      add_column :consignments, :reported, :boolean, default: false
      add_column :reports, :company_id, :integer
  end
end
