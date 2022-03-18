# frozen_string_literal: true

class UserRole < ApplicationRecord

  has_many :users

  AVAIBLE_CODE = %w[c_sadmin c_cadmin  c_cowner c_wadmin c_dispatcher c_inspector c_wmanager].freeze


  def self.find_role_by_name(name)
    UserRole.find_by(name: name)
  end
  def self.find_role_by_code(code)
    UserRole.find_by(code: code)
  end

end
