# frozen_string_literal: true

require 'test_helper'

class DevisePasswordMailerTest < ActionMailer::TestCase
  def setup
    @user = users(:one)
  end

  test 'Send reset password instructions' do
    raw_token = @user.send_reset_password_instructions
    email = Devise::Mailer.reset_password_instructions(@user, raw_token)

    assert_emails 1 do
      email.deliver_now
    end
  end
end
