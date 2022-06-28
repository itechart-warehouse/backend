# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.6'
# Use sqlite3 as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'active_model_serializers', '~> 0.10.0'
gem 'audited', '~> 4.9'
gem 'byebug'
gem 'cancancan', '~> 3.3'
gem 'devise', '~>4.8'
gem 'devise-jwt'
gem 'dip'
gem 'dotenv-rails'
gem 'factory_bot_rails'
gem 'i18n'
gem 'lefthook'
gem 'rspec-rails'
gem 'rubocop'
platforms :mingw do
  gem 'wdm', '>= 0.1.0'
end
gem 'redis-namespace', '~> 1.5', '>= 1.5.2'
gem 'sidekiq'
gem 'sidekiq-scheduler', '~> 2.0', '>= 2.0.8'
# Rich text gem
gem 'actiontext', github: 'rails/actiontext', branch: 'archive', require: 'action_text'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :production do
  gem 'exception_notification'
end

group :development do
  gem 'letter_opener'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
