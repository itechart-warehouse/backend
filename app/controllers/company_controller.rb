# frozen_string_literal: true

class CompanyController < ApplicationController
  respond_to :json
  before_action :access_lvl_helper, :ability_lvl_helper
  load_and_authorize_resource

  def index
    companies = []
    if @ability_lvl == 'system'
      companies = Company.all
    else
      companies << Company.find(@current_user.company_id)
    end
    render json: { companies: companies }, status: :ok
  end

  def show
    company = Company.find(params[:id])
    render json: { company: company }, status: :ok
  end

  def create
    company = Company.new(company_params)
    user = User.new(user_params)
    user.user_role = UserRole.find_role_by_name('Company owner')
    company.users << user
    if company.save
      render json: { company: company, user: user }, status: :created
    else
      render json: { user_errors: user.errors.full_messages, company_errors: company.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    company = Company.find(params[:id])
    if company.update(company_params)
      render json: { company: company }, status: :ok
    else
      render json: { company_errors: company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def check_system_access
    access_error if @ability_lvl != 'system'
  end

  private

  def company_params
    params.require(:company).permit(:name, :address, :phone, :email, :active)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birth_date, :address)
  end
end
