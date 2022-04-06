class AddCompanyIdToGoodsAndConsignments < ActiveRecord::Migration[5.2]
  def change
    add_column :goods, :company_id, :integer
    add_column :consignments, :company_id, :integer
  end
end
