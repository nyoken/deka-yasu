class KeeplistController < ApplicationController
  include ShopsHelper
  before_action :set_keeplist, only: [:index, :destroy]

  def index
    if @user_keep_shops == []
      @rests = []
    else
      rest_url = "https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=#{ENV['GURUNAVI_API_KEY']}&id=#{@keep_shops}"
      parse_json(rest_url)
      @rests = @result["rest"]
    end
  end

  def create
    unless KeepShop.find_by(shop_id: params[:shop_id])
      KeepShop.create(shop_id: params[:shop_id])
    end

    if current_user.keep_shops.size >= KeepShop::KEEP_SHOP_LIMIT
      flash[:danger] = '上限（10件）に達しているため、キープリストに追加できません。'
      redirect_back(fallback_location: root_path) and return
    end

    keep_shop = KeepShop.find_by(shop_id: params[:shop_id])
    current_user.like(keep_shop)
    flash[:success] = "キープリストに追加しました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    keep_shop = KeepShop.find_by(shop_id: params[:id])
    current_user.unlike(keep_shop)
    flash[:success] = "キープリストから削除しました"
    redirect_back(fallback_location: root_path)
  end
end
