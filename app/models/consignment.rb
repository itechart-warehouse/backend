class Consignment < ApplicationRecord
  has_many :goods
  has_many :reports
end
