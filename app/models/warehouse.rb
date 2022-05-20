class Warehouse < ApplicationRecord
  audited

  belongs_to :company
  has_many :users
end
