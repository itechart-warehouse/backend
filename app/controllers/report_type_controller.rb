# frozen_string_literal: true

class ReportTypeController < ApplicationController
  respond_to :json

  def index
    types = ReportType.all
    render json: { ReportTypes: types }, status: :ok
  end
end
