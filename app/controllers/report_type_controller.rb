# frozen_string_literal: true

class ReportTypeController < ApplicationController
  respond_to :json
  skip_before_action :access_helper, :ability_helper

  def index
    render json: { ReportTypes: ReportType.all }, status: :ok
  end
end
