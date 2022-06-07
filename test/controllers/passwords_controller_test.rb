# frozen_string_literal: true

require 'test_helper'

class PasswordsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "Send reset password instructions" do
    post user_password_url, params: { user: { email: @user.email} }
    response_text = JSON.parse(response.body)['messages']

    assert_equal "Email has been sent", response_text
  end

  test "Update user password" do
    raw_token = @user.send_reset_password_instructions
    put user_password_url, params: { reset_password_token: raw_token, password: "1234567", password_confirmation: "1234567" }
    response_text = JSON.parse(response.body)['messages']

    assert_equal "Password successfully updated, try to login with new password", response_text
  end
end
