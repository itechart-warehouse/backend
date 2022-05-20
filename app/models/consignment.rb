class Consignment < ApplicationRecord
  audited

  has_many :goods
  has_many :reports
end
