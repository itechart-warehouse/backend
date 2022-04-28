# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :users
  has_many :warehouses
  has_many :consignments
  has_many :reports
  has_many :goods

  validates :name, presence: true, uniqueness: true
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: email_regex },
            uniqueness: { case_sensitive: false }
  validates :phone, presence: true, length: { minimum: 10, maximum: 20 }
end
