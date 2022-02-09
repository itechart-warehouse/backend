class AddUserIdToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :user_id, :integer
  end
end
