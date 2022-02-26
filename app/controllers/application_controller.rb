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
    @ability_lvl = 'system' if @current_user.user_role == UserRole.find_role_by_name('System admin')
    if  @current_user.user_role == UserRole.find_role_by_name('Company owner') ||
        @current_user.user_role == UserRole.find_role_by_name('Company admin')
      @ability_lvl = 'company'
    end
    @ability_lvl = 'warehouse' if @current_user.user_role == UserRole.find_role_by_name('Warehouse admin')
    if  @current_user.user_role == UserRole.find_role_by_name('Dispatcher') ||
        @current_user.user_role == UserRole.find_role_by_name('Inspector') ||
        @current_user.user_role == UserRole.find_role_by_name('Warehouse Manager')
      @ability_lvl = 'lowest'
    end
  end
end
