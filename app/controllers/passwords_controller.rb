# frozen_string_literal: true

class PasswordsController < Devise::PasswordsController
  skip_before_action :access_helper, :ability_helper

  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      render json: { messages: 'Email has been sent' }, status: :accepted
    else
      render json: { messages: "Couldn't send email" }, status: :not_acceptable
    end
  end

  def update
    resource = User.with_reset_password_token(params[:reset_password_token])
    if resource && resource.reset_password(params[:password], params[:password_confirmation])
      render json: { messages: 'Password successfully updated, try to login with new password' }, status: :ok
    else
      render json: { messages: resource&.errors&.full_messages || "blank_user" }, status: :unprocessable_entity
    end
  end
end
