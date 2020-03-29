class HomeController < ApplicationController
  def index
    pref_url = "https://api.gnavi.co.jp/master/PrefSearchAPI/v3/?keyid=#{ENV['GURUNAVI_API_KEY']}"
    parse_json(pref_url)
    @prefs = @result["pref"]

    category_url = "https://api.gnavi.co.jp/master/CategoryLargeSearchAPI/v3/?keyid=#{ENV['GURUNAVI_API_KEY']}"
    parse_json(category_url)
    @categories = @result["category_l"]
  end
end
