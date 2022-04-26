# frozen_string_literal: true

class ReportTypeController < ApplicationController
  respond_to :json
  skip_before_action :access_lvl_helper, :ability_lvl_helper

  def index
    types = ReportType.all
    render json: { ReportTypes: types }, status: :ok
  end
end
