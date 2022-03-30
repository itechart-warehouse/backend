# frozen_string_literal: true

class ConsignmentController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper
  # load_and_authorize_resource

  def create
    consignment = Consignment.new(consignment_params)
    consignment.update(date: Time.new, user_id: @current_user.id)
    if consignment.save
      render json: { consignment: consignment}, status: :created
    else
      render json: {consignment_errors: consignment.errors.full_messages},
             status: :unprocessable_entity
    end
  end

  private

  def consignment_params
    params.require(:consignment).permit(:status,
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
  end
end
