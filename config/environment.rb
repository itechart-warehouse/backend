# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'gmail.com',
  user_name:            ENV['MAILER_EMAIL_ADDRESS'],
  password:             ENV['MAILER_EMAIL_PASSWORD'],
  authentication:       :plain,
  enable_starttls_auto: true
}