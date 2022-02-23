# frozen_string_literal: true

class UserRole < ApplicationRecord

  has_many :users

  def self.find_role_by_name(name)
    UserRole.find_by(name: name)
  end

end
