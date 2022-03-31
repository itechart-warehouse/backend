class Warehouse < ApplicationRecord
  has_many :sections
  belongs_to :company
  has_many :users
  # after_create :create_sections

def create_sections
warehouse = self
area = warehouse.area.to_i / 4
Section.create(name: 'Type1', area: area, warehouse_id: warehouse.id)
Section.create(name: 'Type2', area: area, warehouse_id: warehouse.id)
Section.create(name: 'Type3', area: area, warehouse_id: warehouse.id)
Section.create(name: 'Type4', area: area, warehouse_id: warehouse.id)
end

end
