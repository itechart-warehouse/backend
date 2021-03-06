# frozen_string_literal: true

class ReportsController < ApplicationController
  respond_to :json
  load_and_authorize_resource
  before_action :reports, only: %i[index index_where_consigment_id]

  def index
    data = []
    @reports.each do |report|
      data << {
        report: report,
        report_type: report.report_type.name
      }
    end
    render json: { reports: data }, status: :ok
  end

  def show_reported
    report = Report.find(params[:report_id])
    render json: { reported_goods: report.reported_goods }, status: :ok
  end

  def index_where_consigment_id
    data = []
    @reports.each do |report|
      next unless report.consignment_id == params[:consignment_id].to_i

      data << {
        report: report,
        report_type: report.report_type.name,
        user: User.find(report.user_id),
        consignment: Consignment.find(report.consignment_id)
      }
    end
    render json: { reports: data }, status: :ok
  end

  def create
    report = Report.new(report_params)
    report.update(report_date: Time.new, user_id: @current_user.id,
                  consignment_id: params[:id], company_id: @current_user.company_id)
    if report.save
      adaptiv_reports_goods(report)
      render json: { report: report, report_type: report.report_type.name, goods: report.reported_goods }, status: :created
    else
      render json: { report_errors: report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def adaptiv_reports_goods(report)
    consignment = Consignment.find(params[:id])
    adaptiv_reports_goods_default(report)
    adaptiv_reports_goods_after_place(consignment, report) unless consignment.warehouse_id.nil?
  end

  def adaptiv_reports_goods_default(report)
    return if goods_params.nil?

    goods = goods_params[:reported]
    goods.each do |good|
      good_info = Good.find(good[:id])
      ReportedGood.create(name: good_info.name, reported_quantity: good[:quantity].to_i,
                          quantity: good_info.quantity,
                          status: ReportType.find(report.report_type_id).name,
                          bundle_number: good_info.bundle_number,
                          bundle_seria: good_info.bundle_seria, date: Time.new,
                          consignment_id: report.consignment_id,
                          report_id: report.id, good_id: good_info.id)
    end
  end

  def adaptiv_reports_goods_after_place(consignment, report)
    reported_area = 0
    report.reported_goods.each { |goods| reported_area += goods.reported_quantity.to_i }
    warehouse = Warehouse.find(consignment.warehouse_id)
    warehouse.update(reserved: warehouse.reserved.to_i - reported_area)
  end

  private

  def reports
    @reports ||= Report.all
  end

  def goods_params
    params.require(:report).permit!
  end

  def report_params
    params.require(:report).permit(:description, :report_type_id)
  end
end
