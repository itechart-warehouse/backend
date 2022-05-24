# frozen_string_literal: true

class WarehouseAuditSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :company, :data

  def company
    object.company_id ? Company.find(object.company_id).name : ''
  end

  def data
    object.created_at
  end
end
