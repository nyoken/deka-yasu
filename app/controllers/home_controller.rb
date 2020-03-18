class HomeController < ApplicationController
  def index
    url = "https://api.gnavi.co.jp/master/PrefSearchAPI/v3/?keyid=#{ENV['GURUNAVI_API_KEY']}"
    parse_json(url)
    @prefs = @result["pref"]
  end
end
