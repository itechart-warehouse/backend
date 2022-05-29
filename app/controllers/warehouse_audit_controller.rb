# frozen_string_literal: true

class WarehouseAuditController < ApplicationController
  before_action :initialize_search, only: :index

  def index
    statistics = WarehouseAudit.where.not(user_id: nil)
    render json: statistics
    handle_search_name
    handle_filters
    # handle_filters_date
  end

  def initialize_search
    @statistics = WarehouseAudit.alphabetical
    session[:search_name] ||= params[:search_name]
    session[:filter] = params[:filter]
    params[:filter_option] = nil if params[:filter_option] == ''
    session[:filter_option] = params[:filter_option]
  end

  def handle_search_name
    @users = if session[:search_name]
               User.where('name LIKE ?', "%#{session[:search_name].titleize}%")
               @statistics = @statistics.where(code: @users.pluck(:statistic))
             else
               @users = User.all
             end
  end

  def handle_filters
    if session[:filter_option] && session[:filter] == 'create'
      @users = @users.where(action: session[:filter_option])
      @statistics = @statistics.where(code: @users.pluck(:statistic))
    elsif session[:filter_option] && session[:filter] == 'update'
      @statistics = @statistics.where(code: session[:filter_option])
    end
  end

  # def handle_filters_date
  #   if params[:start_date].present? && params[:end_date].present?
  #     session[:start_date] = Date.parse(params[:start_date])
  #     session[:end_date] = Date.parse(params[:end_date])
  #   else
  #     session[:start_date] = Time.zone.today - 30.days
  #     session[:end_date] = Time.zone.today
  #   end
  #
  #   start_date = Time.zone.parse(params[:start_date]).beginning_of_day
  #   end_date = Time.zone.parse(params[:end_date]).end_of_day
  #   session[:report_data] = WarehouseAudit.where('created_at >= ?', start_date).where('created_at <= ?', end_date)
  # end
end
