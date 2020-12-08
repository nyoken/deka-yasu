# frozen_string_literal: true

require 'addressable/uri'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def get_gurunavi_response(element, query = nil)
    fqdn = 'https://api.gnavi.co.jp'
    version = 'v3'
    keyid = "keyid=#{Rails.application.credentials.gurunavi[:api_key]}"
    api_url = if element == 'RestSearchAPI'
                "#{fqdn}/#{element}/#{version}/?#{keyid}&#{query}"
              else
                "#{fqdn}/master/#{element}/#{version}/?#{keyid}"
              end
    url = Addressable::URI.encode(api_url)
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    @result = JSON.parse(json)
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[email username password password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end
