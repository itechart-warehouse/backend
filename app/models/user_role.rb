# frozen_string_literal: true

class UserRole < ApplicationRecord
  has_many :users
end
