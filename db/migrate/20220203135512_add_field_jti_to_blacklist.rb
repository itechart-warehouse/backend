class AddFieldJtiToBlacklist < ActiveRecord::Migration[5.2]
  def change
    add_column :blacklists, :jti, :string, null: false
    add_column :blacklists, :exp, :datetime, null: false
    add_index :blacklists, :jti, unique: true
  end
end
