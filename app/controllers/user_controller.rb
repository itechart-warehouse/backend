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
end
