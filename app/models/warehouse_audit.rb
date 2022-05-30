require 'audited/audit'

class WarehouseAudit < Audited::Audit
  before_save :set_user_data

  def self.alphabetical
    user = ::Audited.store[:current_user].try!(:call)
      if user
        self.all.order(:username)
      end
  end

  def set_user_data
    user = ::Audited.store[:current_user].try!(:call)
    if user
      self.user_id = user&.id
      self.username = user&.first_name + " " + user&.last_name
      self.company_id = user&.company_id
    end
  end

  def self.search_name(search_name)
    if search_name
      where(['name LIKE ?', "%#{search_name}%"])
    else
      all
    end
  end

  def self.search_action(action)
    if action
      where(['action LIKE ?', action]) if action.present?
    else
      all
    end
  end

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
