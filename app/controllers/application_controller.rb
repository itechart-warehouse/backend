# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Paginatable
  rescue_from CanCan::AccessDenied, with: :access_error unless config.consider_all_requests_local
  before_action :access_helper, :ability_helper

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def page
    ((params.fetch(:page, 0).to_i + 1) * default_page_size) - default_page_size
  end

  def default_page_size
    params[:per_page] ? params[:per_page].to_i : 5
  end

  def access_error
    render json: { error: (I18n.t :no_access) }, status: 401
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: (I18n.t :bad),
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  def ability_system?
    @ability_lvl == UserRole::ABILITY_SYSTEM
  end

  private

  def access_helper
    if request.headers['Authorization']
      decoder = JwtDecoder.new(request.headers['Authorization'])
      @current_user = decoder.user_by_token
    else
      access_error
    end
  end

  def ability_helper
    @ability_lvl = UserRole::ABILITY_SYSTEM if @current_user.sadmin?
    @ability_lvl = UserRole::ABILITY_COMPANY if @current_user.cowner? || @current_user.cadmin?
    @ability_lvl = UserRole::ABILITY_WAREHOUSE if @current_user.wadmin?
    @ability_lvl = UserRole::ABILITY_LOWEST if @current_user.dispatcher? || @current_user.inspector? || @current_user.wmanager?
  end
end
