# frozen_string_literal: true

class ReportSerializer < ActiveModel::Serializer
  attributes :id, :report_date, :description, :user
  belongs_to :report_type
  belongs_to :consignment
  has_many :reported_goods

  def user
    User.find(object.user_id)
  end
end
