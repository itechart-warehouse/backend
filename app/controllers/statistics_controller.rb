# frozen_string_literal: true

class StatisticsController < ApplicationController
  def index
    statistics = Statistics.where.not(user_id: nil).alphabetical_sort
    statistics = statistics.search_name(params[:name]) if params[:name].present?
    statistics = statistics.search_action(params[:actions]) if params[:actions].present?
    statistics = statistics.search_date(params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    statistics, meta = paginate_collection(statistics)
    @serialized_statistics = ActiveModelSerializers::SerializableResource.new(statistics)
    @serialized_count = meta[:total_count]
    render json: { statistic: @serialized_statistics, statistic_count: @serialized_count }
  end
end
