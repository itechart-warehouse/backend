# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://react-warehouse-app.herokuapp.com'

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             expose: %w[access-token expiry token-type Authorization]
  end
end
