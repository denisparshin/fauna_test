class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  respond_to :html, :json
  skip_before_action :verify_authenticity_token

end
