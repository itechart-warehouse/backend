# frozen_string_literal: true

class UserController < ApplicationController
  respond_to :json

  def index
    users = User.all
    json = []
    users.each do |user|
      json << {
        user: user,
        company: user.company
      }
    end
    render json: { users: json }, status: :ok
  end
  def show
    user = User.find(params[:id])
    company = user.company
    role = user.user_role
    render json: { user: user, company: company, role: role }, status: :ok
  end
  def update
    user = User.find(params[:id])
    if user.update(user_params)
    render json: {user: user}, status: :ok
    else
      render json: { user_errors: user.errors }, status: :unprocessable_entity
      end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :birth_date, :address)
  end


end