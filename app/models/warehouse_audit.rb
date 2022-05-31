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
    where("name like %#{query}%")
  }

  # scope :search_action, ->(query) {
  #   where("action like %#{query}%")
  # }

  def self.search_date(start_date, end_date)
    if start_date.present? && end_date.present?
      start_date = Date.parse(start_date)
      end_date = Date.parse(end_date)
    else
      start_date = Time.zone.today - 30.days
      end_date = Time.zone.today
    end
    start_date = Time.zone.parse(start_date).beginning_of_day
    end_date = Time.zone.parse(end_date).end_of_day
    where('created_at >= ?', start_date).where('created_at <= ?', end_date)
  end
end
