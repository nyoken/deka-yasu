class KeeplistController < ApplicationController
  def index
  end

  def create
    unless KeepShop.find_by(shop_id: params[:shop_id])
      KeepShop.create(shop_id: params[:shop_id])
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
