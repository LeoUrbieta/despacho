source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "3.2.9"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 8.0"
# Use Puma as the app server
gem "puma", ">= 5.0"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use Active Model has_secure_password
gem "bcrypt", "~> 3.1.7"
# Usar gema de posgresql
gem "pg"
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.4", require: false
# Incluir gema para auditoría en base de datos
gem "audited"
# Incluir gema para evitar spam en la forma de peticiones
gem "invisible_captcha"
# Import Map Rails
gem "importmap-rails"
# Stimulus rails
gem "stimulus-rails"
# Turbo gem
gem "turbo-rails"
# Gema para enviar correos electrónicos
gem "mail", "~> 2.7"
# Gema para usar Active Storage con Amazon S3
gem "aws-sdk-s3", "~> 1.113"
# Gema para usar recaptcha en login form
gem "recaptcha", "~> 5.10"
# Gema para usar solid queue
gem "solid_queue"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false
  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
  gem 'minitest', '< 6.0'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara"
  gem "selenium-webdriver"
  gem "rails-controller-testing"
end
