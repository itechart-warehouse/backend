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

  def company_params
    params.require(:company).permit(:id)

  def show
    user = User.find(params[:id])
    company = user.company
    role = user.user_role
    render json: { user: user, company: company, role: role }, status: :ok

  def create
    user = User.new(user_params)
    company = Company.find_by(company_params)
    company.users << user
    if user.save
      render json: { user: user }, status: :created
    else
      render json: { user_errors: user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birth_date, :address, :company_id,
                                 :role_id)
  end

  end
end
