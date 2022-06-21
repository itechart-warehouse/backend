# frozen_string_literal: true

class ReportsController < ApplicationController
  respond_to :json
  load_and_authorize_resource

  def show_reported
    report = Report.find(params[:report_id])
    render json: report
  end

  def index_where_consigment_id
    reports, meta = paginate_collection(Consignment.find(params[:consignment_id]).reports)
    render json: { reports: reports.to_json(include: [user: { only: %i[first_name last_name id] },
                                                      report_type: { only: :name },
                                                      consignment: { only: %i[consignment_seria consignment_number ] }]),
                   total_count: meta[:total_count] }
  end

  def create
    report = Report.new(report_params)
    report.update(report_date: Time.new, user_id: @current_user.id,
                  consignment_id: params[:id], company_id: @current_user.company_id)
    if report.save
      adaptiv_reports_goods(report)
      render json: report
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
    Warehouse.find(consignment.warehouse_id).update(reserved: warehouse.reserved.to_i - reported_area)
  end

  private

  def goods_params
    params.require(:report).permit!
  end

  def report_params
    params.require(:report).permit(:description, :report_type_id)
  end
end
