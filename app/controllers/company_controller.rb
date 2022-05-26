# frozen_string_literal: true

class CompanyController < ApplicationController
  respond_to :json
  load_and_authorize_resource
  before_action :company, only: %i[show update]

  def index
    companies = []
    page = params[:page].to_i * default_page_size
    if ability_system?
      companies = Company.all.limit(default_page_size)
    else
      companies << Company.find(@current_user.company_id).offset(page).limit(default_page_size)
    end
    render json: { companies: companies, company_count: company_count }
  end

  def show
    render json: @company
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
    if @company.update(company_params)
      render json: { company: @company }, status: :ok
    else
      render json: { company_errors: @company.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def check_system_access
    access_error if @ability_lvl != UserRole::ABILITY_SYSTEM
  end

  private

  def company_count
    if ability_system?
      Company.all.count
    else
      Company.find(@current_user.company_id).count
    end
  end

  def company
    @company ||= Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name, :address, :phone, :email, :active)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birth_date, :address)
  end
end
