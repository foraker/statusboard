class ApplicationController < ActionController::Base
  before_action  :authenticate
  protect_from_forgery with: :null_session

  private

  def authenticate
    return true if ip_whitelisted?
    authenticate_or_request_with_http_basic do |name, password|
      name == secrets['name'] && password == secrets['pass']
    end
  end

  def ip_whitelisted?
    secrets['whitelist_ips'].split(',').any? do |whitelisted_ip|
      /#{whitelisted_ip}/ =~ request.remote_ip
    end
  end

  def secrets
    Rails.application.secrets.basic_auth
  end
end
