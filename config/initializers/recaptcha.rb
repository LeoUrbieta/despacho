Recaptcha.configure do |config|
  config.site_key  = Rails.application.credentials.dig(:recaptcha,:site)
  config.secret_key = Rails.application.credentials.dig(:recaptcha,:secret)
end
