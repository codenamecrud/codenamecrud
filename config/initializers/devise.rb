Devise.setup do |config|
  config.mailer_sender = 'frey@list.ru'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.authentication_keys   = [:login]
  config.skip_session_storage  = [:http_auth]
  config.reset_password_keys   = [:name, :email]
  config.confirmation_keys     = [:name, :email]

  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.secret_key = 'f43cc134134eb9c9097939379556ef5ee4258a3a038b9569b84d2ea05a8f66d590e3d6dcc51c88c72d8dded8bac16a9ed96bf2a02b9b18da3a027af51a9b3278'
end
