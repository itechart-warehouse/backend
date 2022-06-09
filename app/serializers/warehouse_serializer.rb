# frozen_string_literal: true

class WarehouseSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :phone, :area, :reserved, :active, :user
  belongs_to :company
  has_many :users

  def user
    object.users.find_by(user_role_id: UserRole.find_role_by_name('Warehouse admin').id)
  end
end
