class ConsignmentSerializer < ActiveModel::Serializer
  attributes :id, :consignment_seria, :consignment_number, :bundle_seria, :bundle_number, :status, :truck_number, :first_name, :second_name, :passport, :contractor_name, :date, :checked_date, :placed_date, :rechecked_date, :shipped_date, :reported, :actions
  has_many :goods
  has_many :reports

  def actions
    user = case object.status
           when 'Registered'
             User.find(object.user_id)
           when 'Checked'
             User.find(object.checked_user_id)
           when 'Placed'
             User.find(object.placed_user_id)
           when 'Checked before shipment'
             User.find(object.rechecked_user_id)
           when 'Shipped'
             User.find(object.shipped_user_id)
           end
    return { user: user }
  end
end
