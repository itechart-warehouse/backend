require 'audited/audit'

class WarehouseAudit < Audited::Audit
  before_save :set_user_data

  def set_user_data

  end
end
