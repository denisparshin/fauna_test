Devise.setup do |config|
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.authentication_keys = [ :login ]
  config.reset_password_keys = [ :username ]
  config.confirmation_keys = [ :username ]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.encryptor = :md5
end
