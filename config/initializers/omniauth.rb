# frozen_string_literal: true

# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.allowed_request_methods = %i[post get]
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], {
    provider_ignores_state: true
  }
end
