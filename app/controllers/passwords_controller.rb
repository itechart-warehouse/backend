class PasswordsController < Devise::PasswordsController
  respond_to :json

  def edit
    render json: params[:reset_password_token].to_json
  end

end
