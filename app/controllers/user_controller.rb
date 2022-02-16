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
    render json: { user: user, company: company }, status: :ok
  end
end
