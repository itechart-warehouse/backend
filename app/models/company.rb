# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :users
  has_many :warehouses
  has_many :consignments
  has_many :reports
  has_many :goods

  validates :name, presence: true, uniqueness: true, length: { minimum: 5, maximum: 50 }
  validates :address, presence: true, length: { minimum: 5, maximum: 100 }
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: email_regex },
            uniqueness: { case_sensitive: false }
  phone_regex=/\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/
  validates :phone, presence: true, length: { minimum: 10, maximum: 14 },
            format: { with: phone_regex }
end
