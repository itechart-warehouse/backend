# frozen_string_literal: true

class Settings::CountriesController < ApplicationController
  respond_to :json
  load_and_authorize_resource
  before_action :find_country, only: %i[update destroy]

  def index
    countries, meta = paginate_collection(Country.all)
    total_count = meta[:total_count]
    render json: { countries: countries, country_count: total_count }, status: :ok
  end

  def create
    country = Country.new(country_params)
    if country.save
      render json: country
    else
      render json: { country_errors: country.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @country.update(country_params)
      render json: @country
    else
      render json: { country_errors: @country.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @country.destroy
      render status: :ok
    else
      render json: { country_errors: @country.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index_without_pagination
    countries = Country.all
    render json: { countries: countries }
  end

  private

  def find_country
    @country = Country.find(params[:id])
  end

  def country_params
    params.require(:country).permit(:name)
  end
end
