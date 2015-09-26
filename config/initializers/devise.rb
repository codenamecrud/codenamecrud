Devise.setup do |config|
  config.mailer_sender = 'frey@list.ru'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.authentication_keys   = [:login]
  config.skip_session_storage  = [:http_auth]
  config.reset_password_keys   = [:name]
  config.confirmation_keys     = [:name]

  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.secret_key = ENV['DEVISE_SECRET_KEY']
end
