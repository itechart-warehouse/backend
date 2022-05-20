# frozen_string_literal: true

class GoodsController < ApplicationController
  respond_to :json
  #  load_and_authorize_resource

  def index
    consignment = Consignment.find(params[:id])
    goods = consignment.goods
    render json: goods
  end
end
