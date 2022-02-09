class CompanyController < ApplicationController
  respond_to :json

  def create
    company = Company.new(company_params)
    user = User.new(user_params)
    user.companies << company
    if user.save
      render json: { company: company, user: user }, status: :created
    else
      render json: { user_errors: user.errors, company_errors:company.errors }, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :address, :phone, :email)
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :birth_date, :address)
  end

end
