# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  respond_to :json
  skip_before_action :access_helper, :ability_helper

  def create
    build_resource(sign_up_params)
    resource.save
    render_resource(resource)
  end
end
