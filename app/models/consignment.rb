class Consignment < ApplicationRecord
  audited
  has_many :goods
  has_many :reports

  scope :by_seria_number, ->(search){
    seria , number =search.split
    query = "consignment_seria iLIKE '#{seria}%'"
    query += "and consignment_number::text  iLIKE '#{number}'" if number.present?
    where(query)
  }
end
