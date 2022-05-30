# frozen_string_literal: true

class WarehouseAuditController < ApplicationController
  def index
    statistics = WarehouseAudit.where.not(user_id: nil)
    render json: statistics
    params[:action] = nil if params[:action] == ''
    params[:search_name] = nil if params[:search_name] == ''
    @statistics = WarehouseAudit.alphabetical
    @statistics = WarehouseAudit.search_name(params[:search_name])
    @statistics = WarehouseAudit.search_action(params[:action])
    # @statistics = WarehouseAudit.search_date(params[:start_date], params[:end_date])
  end
end
