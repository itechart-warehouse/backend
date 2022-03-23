class Driver < ApplicationRecord
  # belongs_to :contractor

  validates :first_name, presence: true, length: { maximum: 25 }
  validates :last_name, presence: true, length: { maximum: 25 }
  validates :passport_number, presence: true, length: { maximum: 20 }
  validates :passport_info, presence: true, length: { maximum: 100 }
end