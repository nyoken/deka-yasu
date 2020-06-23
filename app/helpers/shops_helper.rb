module ShopsHelper
  def set_keeplist
    @user_keep_shops = user_signed_in? ? current_user.user_keep_shops.pluck('keep_shop_id') : []
    @keep_shops = user_signed_in? ? @user_keep_shops.map{ |id| KeepShop.find(id) }.pluck('shop_id').join(',') : []
  end
end
