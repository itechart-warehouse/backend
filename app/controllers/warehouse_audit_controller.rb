# frozen_string_literal: true

class WarehouseAuditController < ApplicationController
  def index
    statistics = WarehouseAudit.where.not(user_id: nil).alphabetical_sort
    statistics = statistics.search_name(params[:name]) if params[:name].present?
    statistics = statistics.search_action(params[:actions]) if params[:actions].present?
    if params[:start_date].present? && params[:end_date].present?
      statistics = statistics.search_date(params[:start_date], params[:end_date])
    end
    render json: statistics
  end
end
