# frozen_string_literal: true

class DriverController < ApplicationController
  # respond_to :json
  # before_action :access_lvl_helper, :ability_lvl_helper
  # load_and_authorize_resource
  #
  # def index
  #   drivers = Driver.all
  #   render json: { drivers: drivers }, status: :ok
  # end
  #
  # def show
  #   driver = Driver.find(params[:id])
  #   # contractor = driver.contractor
  #   #
  #   # TODO add contractor to json
  #   #
  #   render json: { driver: driver }, status: :ok
  # end
  #
  # def create
  #   driver = Driver.new(driver_params)
  #   if driver.save
  #     render json: { driver: driver }, status: :created
  #   else
  #     render json: { driver_errors: driver.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end
  #
  # private
  #
  # def driver_params
  #   params.require(:driver).permit(:first_name, :last_name, :passport_number, :passport_info)
  # end
end
