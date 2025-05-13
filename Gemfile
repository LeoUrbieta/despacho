source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '3.2.8'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.0'
# Use Puma as the app server
gem 'puma', '>= 5.0'
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
#Usar gema de posgresql
gem 'pg'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false
# Incluir gema para auditoría en base de datos
gem 'audited'
# Incluir gema para evitar spam en la forma de peticiones
gem 'invisible_captcha'
# Import Map Rails
gem 'importmap-rails'
# Stimulus rails
gem 'stimulus-rails'
# Turbo gem
gem 'turbo-rails'
#Gema para enviar correos electrónicos
gem "mail", "~> 2.7"
#Gema para usar Active Storage con Amazon S3
gem "aws-sdk-s3", "~> 1.113"
#Gema para usar recaptcha en login form
gem "recaptcha", "~> 5.10"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Use sqlite3 as the database for Active Record
  #gem 'sqlite3', '~> 1.4'
end

group :development do
  require 'rbconfig'
#      if RbConfig::CONFIG['target_os'] =~ /(?i-mx:bsd|dragonfly)/
#        gem 'rb-kqueue', '>= 0.2'
#      end
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '~> 3.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'brakeman'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '= 5.3.1'
  gem 'rails-controller-testing'
end
