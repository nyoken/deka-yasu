# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    get_gurunavi_response('PrefSearchAPI')
    @prefs = @result['pref']

    get_gurunavi_response('CategoryLargeSearchAPI')
    @categories = @result['category_l']
  end
end
