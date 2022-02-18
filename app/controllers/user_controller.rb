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
end
