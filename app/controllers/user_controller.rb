class UserController < ApplicationController
  respond_to :json

  def index
    users = User.all
    render json: { users: users }, status: :ok
  end
end