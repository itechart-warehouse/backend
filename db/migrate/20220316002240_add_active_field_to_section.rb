class AddActiveFieldToSection < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :active, :boolean, default: true
  end
end
