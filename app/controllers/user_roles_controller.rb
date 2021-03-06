# frozen_string_literal: true

class UserRolesController < ApplicationController
  respond_to :json
  load_and_authorize_resource

  def index
    roles = UserRole.all
    render json: { roles: roles }, status: :ok
  end
end
