CarrierWave.configure do |config|
  config.ftp_host = ENV["CR_HOST"]
  config.ftp_port = 21
  config.ftp_user = ENV["CR_USER"]
  config.ftp_passwd = ENV["CR_PASSWORD"]
  config.ftp_folder = ENV["CR_PATH"]
  config.ftp_url = ENV["CR_URL"]
  config.ftp_passive = false # false by default
end
