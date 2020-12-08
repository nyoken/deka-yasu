# frozen_string_literal: true

class ShopsController < ApplicationController
  include ShopsHelper
  before_action :set_keeplist, :set_search_area, :set_review

  def index
    query = set_query
    get_gurunavi_response('RestSearchAPI', query)
    if @result['rest'].present?
      set_page_info
      @rests = Kaminari.paginate_array(@result['rest'], total_count: @total_hit_count).page(params[:page]).per(20)
    else
      @rests = []
    end
  end

  private

  def set_review
    @review = Review.new
  end

  def set_search_area
    @pref_code = params[:pref_code]
    @category_code = params[:category_code]
    get_gurunavi_response('GAreaSmallSearchAPI')
    @areas = @result['garea_small'].select { |garea| garea['pref']['pref_code'] == @pref_code }
  end

  def set_query
    default_query = { "e_money": 1,
                      "hit_per_page": 20,
                      "pref": @pref_code,
                      "category_l": @category_code,
                      "offset_page": params[:page] }
    params[:areacode_s] ? default_query.merge(add_query).to_query : default_query.to_query
  end

  def add_query
    { "areacode_s": params[:areacode_s],
      "breakfast": params[:breakfast],
      "lunch": params[:lunch],
      "midnight": params[:midnight],
      "buffet": params[:buffet],
      "bottomless_cup": params[:bottomless_cup],
      "no_smoking": params[:no_smoking] }
  end

  def set_page_info
    # ヒットした総数を取得
    @total_hit_count = @result['total_hit_count']

    # 現在表示している件数を取得
    hit_per_page = @result['hit_per_page']
    page_offset = @result['page_offset']
    start_count = hit_per_page * (page_offset - 1) + 1
    end_count = @total_hit_count < hit_per_page * page_offset ? @total_hit_count : hit_per_page * page_offset
    @now_hit_count = "#{start_count}-#{end_count}"
  end
end
