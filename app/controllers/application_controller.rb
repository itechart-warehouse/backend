# frozen_string_literal: true

class ApplicationController < ActionController::API
  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def access_lvl
    decoder = JwtDecoder.new(request.headers['Authorization'])
    @current_user = decoder.user_by_token
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
end
