# frozen_string_literal: true

class ConsignmentController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper
  # load_and_authorize_resource

  def create
    consignment = Consignment.new(consignment_params)
    consignment.update(date: Time.new, user_id: @current_user.id)
    goods = goods_params

    if consignment.save
      goods.each do |good|
        Goods.create(name: good[:name], quantity: good[:quantity], status: good[:good_status],
                     bundle_seria: good[:bundle_seria], bundle_number: good[:bundle_number], date: Time.new, consignment_id: consignment.id)
      end
      render json: { consignment: consignment }, status: :created
    else
      render json: { consignment_errors: consignment.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def consignment_params
    params.require(:consignment).permit(:consigment_status,
                                        :bundle_seria,
                                        :bundle_number,
                                        :consignment_seria,
                                        :consignment_number,
                                        :truck_number,
                                        :first_name,
                                        :second_name,
                                        :middle_name,
                                        :passport,
                                        :contractor_name)

    # .permit(:good_status, :bundle_seria, :bundle_number, :good_name, :quantity)
  end

  def goods_params
    params.require(:goods)
  end
end
