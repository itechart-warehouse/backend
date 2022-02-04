# frozen_string_literal: true

class Blacklist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  self.table_name = 'blacklists'
end
