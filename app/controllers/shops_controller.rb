class ShopsController < ApplicationController
  def index
    if params[:pref_code]
      @pref_code = params[:pref_code]
      url2 = "https://api.gnavi.co.jp/master/GAreaSmallSearchAPI/v3/?keyid=" + ENV['GURUNAVI_API_KEY']
      url2 = URI.encode(url2) #エスケープ
      uri2 = URI.parse(url2)
      json2 = Net::HTTP.get(uri2)
      result2 = JSON.parse(json2)
      @areas = result2["garea_small"].select{|garea| garea["pref"]["pref_code"] == @pref_code}
    end

    # dotenvで設定したAPIキーを取得し、GURUNAVI_API用URL内に設定
    items = {
      "keyid": ENV['GURUNAVI_API_KEY'],
      "e_money": 1,
      "pref": @pref_code
    }

    if params[:areacode_s]
      items.store("areacode_s", params[:areacode_s])
    end

    query = items.to_query

    url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?"+query
    url=URI.encode(url) #エスケープ
    uri = URI.parse(url)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    @rests = result["rest"]
    @total_count = result["total_hit_count"]
  end
end
