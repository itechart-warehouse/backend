# frozen_string_literal: true

class WarehouseAuditController < ApplicationController
  def index
    statistics = WarehouseAudit.where.not(user_id: nil).alphabetical_sort
    statistics = statistics.search_name(params[:name]) unless params[:name].blank?
    statistics = statistics.search_action(params[:actions]) unless params[:actions].blank?
    statistics = WarehouseAudit.search_date(params[:start_date], params[:end_date]) unless params[:start_date].blank? && params[:end_date].blank?
    render json: statistics
  end
end
