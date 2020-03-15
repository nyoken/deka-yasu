class HomeController < ApplicationController
  def index
    # dotenvで設定したAPIキーを取得し、GURUNAVI_API用URL内に設定
    api_key = ENV['GURUNAVI_API_KEY']

    pref_url = "https://api.gnavi.co.jp/master/PrefSearchAPI/v3/?keyid=" + api_key
    pref_url = URI.encode(pref_url) #エスケープ
    pref_uri = URI.parse(pref_url)
    pref_json = Net::HTTP.get(pref_uri)
    pref_result = JSON.parse(pref_json)
    @prefs = pref_result["pref"]
  end
end
