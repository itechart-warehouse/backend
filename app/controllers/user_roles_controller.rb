# frozen_string_literal: true

class UserRolesController < ApplicationController
  def index
    roles = UserRole.all
    render json: {roles: roles}, status: :ok
  end
end
