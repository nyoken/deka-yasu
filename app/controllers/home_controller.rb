# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    pref_url = "https://api.gnavi.co.jp/master/PrefSearchAPI/v3/?keyid=#{Rails.application.credentials.gurunavi[:api_key]}"
    parse_json(pref_url)
    @prefs = @result['pref']

    category_url = "https://api.gnavi.co.jp/master/CategoryLargeSearchAPI/v3/?keyid=#{Rails.application.credentials.gurunavi[:api_key]}"
    parse_json(category_url)
    @categories = @result['category_l']
  end
end
