class Warehouse < ApplicationRecord
  has_many :sections
  belongs_to :company
  has_many :users
end
