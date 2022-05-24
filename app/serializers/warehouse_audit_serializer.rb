# frozen_string_literal: true

class WarehouseAuditSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :company, :data, :action, :changes, :type

  def company
    object.company_id ? Company.find(object.company_id).name : ''
  end

  def data
    object.created_at.to_s
  end

  def changes
    object.audited_changes
  end

  def type
    object.auditable_type
  end
end
