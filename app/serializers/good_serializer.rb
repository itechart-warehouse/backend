# frozen_string_literal: true

class GoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :quantity, :status, :bundle_number, :bundle_seria, :date, :checked_date, :placed_date, :rechecked_date, :shipped_date, :warehouse
  belongs_to :consignment
  has_many :reported_goods

  def warehouse
    object.consignment.warehouse_id ? Warehouse.find(object.consignment.warehouse_id) : ''
  end
end
