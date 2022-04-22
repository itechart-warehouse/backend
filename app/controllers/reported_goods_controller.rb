# frozen_string_literal: true

class ReportedGoodsController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper
  #  load_and_authorize_resource
end
