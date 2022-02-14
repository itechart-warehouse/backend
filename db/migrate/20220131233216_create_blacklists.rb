# frozen_string_literal: true

class CreateBlacklists < ActiveRecord::Migration[5.2]
  def change
    create_table :blacklists, &:timestamps
  end
end
