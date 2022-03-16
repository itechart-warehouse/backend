# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from CanCan::AccessDenied, with: :access_error unless config.consider_all_requests_local

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def access_lvl_helper
    if request.headers['Authorization']
      decoder = JwtDecoder.new(request.headers['Authorization'])
      @current_user = decoder.user_by_token
    else
      access_error
    end
  end

  def access_error
    render json: { error: 'Access restricted.' }, status: 401
  end

  def validation_error(resource)
    render json: {
      errors: [
        {
          status: '400',
          title: 'Bad Request',
          detail: resource.errors,
          code: '100'
        }
      ]
    }, status: :bad_request
  end

  def ability_lvl_helper
    @ability_lvl = 'system' if @current_user.c_sadmin?
    if  @current_user.c_cowner? || @current_user.c_cadmin?
      @ability_lvl = 'company'
    end
    @ability_lvl = 'warehouse' if @current_user.c_wadmin?
    if  @current_user.c_dispatcher? || @current_user.c_inspector? || @current_user.c_wmanager?
      @ability_lvl = 'lowest'
    end
  end
end
