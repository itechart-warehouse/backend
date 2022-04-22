class Good < ApplicationRecord
  belongs_to :consignment
  has_many :reported_goods
end
