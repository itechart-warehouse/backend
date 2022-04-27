# frozen_string_literal: true

class UserRole < ApplicationRecord

  has_many :users

  AVAIBLE_CODE = %w[c_sadmin c_cadmin  c_cowner c_wadmin c_dispatcher c_inspector c_wmanager].freeze
  SYSTEM_ADMIN = "System admin".freeze
  COMPANY_OWNER = "Company owner".freeze
  COMPANY_ADMIN =  "Company admin".freeze
  WAREHOUSE_ADMIN =  "Warehouse admin".freeze
  DISPATCHER = "Dispatcher".freeze
  INSPECTOR = "Inspector".freeze
  MANAGER =  "Warehouse Manager".freeze
  ABILITY_SYSTEM = "system".freeze
  ABILITY_COMPANY = "company".freeze
  ABILITY_WAREHOUSE = "warehouse".freeze
  ABILITY_LOWEST = "lowest".freeze

  def self.find_role_by_name(name)
    UserRole.find_by(name: name)
  end
  def self.find_role_by_code(code)
    UserRole.find_by(code: code)
  end

end
