class ReportsController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper
  load_and_authorize_resource

  def index
    reports = Report.all
    data = []
    reports.each do |report|
      data << {
        report: report,
        report_type: report.report_type.name
      }
    end
      render json: { reports: data}, status: :ok
  end

  def index_where_consigment_id
    reports = Report.where(consignment_id: params[:id])
    data = []
    reports.each do |report|
      data << {
        report: report,
        report_type: report.report_type.name,
        user: User.find(report.user_id)
      }
    end
      render json: { reports: data}, status: :ok
  end

  def create
    report = Report.new(report_params)
    report.update(report_date: Time.new, user_id: @current_user.id,
                  consignment_id: params[:id], company_id: @current_user.company_id)
    if report.save
      render json: { report: report, report_type: report.report_type.name}, status: :created
    else
      render json: { report_errors: report.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def report_params
    params.require(:report).permit(:description, :report_type_id)
  end

end
