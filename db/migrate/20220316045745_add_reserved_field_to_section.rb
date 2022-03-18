class AddReservedFieldToSection < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :reserved, :string, default: '0'
  end
end
