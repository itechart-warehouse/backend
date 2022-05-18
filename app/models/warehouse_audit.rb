require 'audited/audit'

class WarehouseAudit < Audited::Audit
  before_save :set_user_data

  def set_user_data
    user = ::Audited.store[:current_user].try!(:call)
    self.user_id = user&.id
    self.username = user&.first_name + " " + user&.last_name
    self.company_id = user&.company_id
  end
end
