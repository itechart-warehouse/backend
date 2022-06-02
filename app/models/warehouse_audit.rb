require 'audited/audit'

class WarehouseAudit < Audited::Audit
  before_save :set_user_data

  def set_user_data
    user = ::Audited.store[:current_user].try!(:call)
    if user
      self.user_id = user&.id
      self.username = user&.first_name + " " + user&.last_name
      self.company_id = user&.company_id
    end
  end

  scope :alphabetical_sort, -> {
    order(username: :asc)
  }

  scope :search_name, ->(query) {
    where("username ILIKE :query", query: "%#{query}%")
  }

  scope :search_action, ->(actions) {
    where(action: actions)
  }

  scope :search_date, ->(start_date, end_date) {
    start_date, end_date = if start_date.present? && end_date.present?
                             [Time.zone.parse(start_date).beginning_of_day, Time.zone.parse(end_date).end_of_day]
    else
      [Time.current - 30.days, Time.current]
                           end
    where('created_at between ? and ?', start_date, end_date)
  }
end
