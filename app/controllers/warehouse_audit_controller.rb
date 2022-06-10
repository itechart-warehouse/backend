# frozen_string_literal: true

class WarehouseAuditController < ApplicationController
  def index
    statistics, meta = paginate_collection(WarehouseAudit.where.not(user_id: nil).alphabetical_sort)
    statistics = statistics.search_name(params[:name]) if params[:name].present?
    statistics = statistics.search_action(params[:actions]) if params[:actions].present?
    statistics = statistics.search_date(params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    @serialized_statistics = ActiveModelSerializers::SerializableResource.new(statistics)
    @serialized_count = meta[:total_count]
    # render json: statistics
    render json: { statistic: @serialized_statistics, warehouse_audits_count: @serialized_count }
  end
end
