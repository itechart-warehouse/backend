# frozen_string_literal: true

class WarehouseAuditSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :company, :data, :action, :changes, :type

  def company
    object.company&.name
  end

  def data
    I18n.l(object.created_at, format: :default)
  end

  def changes
    object.audited_changes
  end

  def type
    object.auditable_type
  end
end
