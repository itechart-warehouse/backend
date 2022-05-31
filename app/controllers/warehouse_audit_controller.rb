# frozen_string_literal: true

class WarehouseAuditController < ApplicationController
  def index
    statistics = WarehouseAudit.where.not(user_id: nil)
    params[:action] = nil if params[:action] == ''
    params[:search_name] = nil if params[:search_name] == ''
    WarehouseAudit.alphabetical
    WarehouseAudit.search_name(params[:name])
    WarehouseAudit.search_action(params[:action])
    # @statistics = WarehouseAudit.search_date(params[:start_date], params[:end_date])
    render json: statistics
  end
end
