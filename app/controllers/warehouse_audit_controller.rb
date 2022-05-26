# frozen_string_literal: true

class WarehouseAuditController < ApplicationController
  def index
    statistics = WarehouseAudit.where.not(user_id: nil)
    render json: statistics
  end
end
