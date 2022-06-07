# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :access_helper, :ability_helper

  # GET /resource/confirmation/new
  # def new
  #   super
  # end

  # POST /resource/confirmation
  # def create
  #   super
  # end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    reset_token = params[:reset_password_token]
    yield resource if block_given?

    if resource.errors.empty? || resource.confirmed?
      redirect_to "http://#{ENV['FRONT_END_URL']}/users/password/edit?reset_password_token=#{reset_token}"
    else
      respond_with_navigational(resource.errors, status: :unprocessable_entity) { render :new }
    end
  end

  # protected

  # The path used after resending confirmation instructions.
  # def after_resending_confirmation_instructions_path_for(resource_name)
  #   super(resource_name)
  # end
end
