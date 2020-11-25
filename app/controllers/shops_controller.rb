class ShopsController < ApplicationController
  include ShopsHelper
  before_action :set_keeplist, only: [:index]

  def index
    area_url = "https://api.gnavi.co.jp/master/GAreaSmallSearchAPI/v3/?keyid=#{Rails.application.credentials.gurunavi[:api_key]}"
    parse_json(area_url)
    @areas = @result["garea_small"].select{|garea| garea["pref"]["pref_code"] == params[:pref_code]}
    @pref_code = params[:pref_code] if params[:pref_code].present?
    @review = Review.new

    # dotenvで設定したAPIキーを取得し、GURUNAVI_API用URL内に設定
    query_items = {
      "keyid": Rails.application.credentials.gurunavi[:api_key],
      "e_money": 1,
      "hit_per_page": 20,
      "pref": params[:pref_code],
      "areacode_s": params[:areacode_s],
      "category_l": params[:category_code],
      "offset_page": params[:page],
      "breakfast": params[:breakfast],
      "lunch": params[:lunch],
      "midnight": params[:midnight],
      "buffet": params[:buffet],
      "bottomless_cup": params[:bottomless_cup],
      "no_smoking": params[:no_smoking]
    }
    query = query_items.to_query

    rest_url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?" + query
    parse_json(rest_url)
    @total_hit_count = @result["total_hit_count"]
    if @result["rest"].present?
      @rests = Kaminari.paginate_array(@result["rest"], total_count: @total_hit_count).page(params[:page]).per(20)
      hit_per_page = @result["hit_per_page"]
      page_offset = @result["page_offset"]

      @start_count = hit_per_page * (page_offset - 1) + 1
      @end_count = @total_hit_count < hit_per_page * page_offset ? @total_hit_count : hit_per_page * page_offset
    else
      @rests = []
    end
  end
end
