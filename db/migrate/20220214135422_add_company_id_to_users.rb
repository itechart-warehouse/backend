class AddCompanyIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :company_id, :integer
  end
end
