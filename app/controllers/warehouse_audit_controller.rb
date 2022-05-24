# frozen_string_literal: true

class WarehouseAuditController < ApplicationController
  def index
    statistics = WarehouseAudit.all
    render json: statistics
  end
end
