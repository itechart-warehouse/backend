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

  def getCompanyAndRolesList
    roles = UserRole.all
    companies = Company.all
    render json: { companies: companies, roles: roles }, status: :ok
  end

  private

  def company_params
    params.require(:company).permit(:id)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birth_date, :address, :company_id,
                                 :user_role_id)
  end
end
