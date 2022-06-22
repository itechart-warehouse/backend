# frozen_string_literal: true

class Settings::CitiesController < ApplicationController
  respond_to :json
  load_and_authorize_resource
  before_action :find_city, only: %i[update destroy]
  before_action :find_country, only: %i[index]

  def index
    cities, meta = paginate_collection(@country.cities)
    total_count = meta[:total_count]
    render json: { cities: cities, city_count: total_count }, status: :ok
  end

  def create
    city = City.new(city_params)
    if city.save
      render json: city
    else
      render json: { city_errors: city.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @city.update(city_params)
      render json: @city
    else
      render json: { city_errors: @city.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @city.destroy
      render status: :ok
    else
      render json: { city_errors: @city.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_city
    @city = City.find(params[:id])
  end

  def find_country
    @country = Country.find(params[:country_id])
  end

  def city_params
    params.require(:city).permit(:name, :country_id)
  end
end
