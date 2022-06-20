class Warehouse < ApplicationRecord
  audited

  belongs_to :company
  has_many :users

  scope :by_name,->(search){where("name ilike '#{search}%'")}
end
