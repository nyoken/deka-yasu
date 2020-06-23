module KeeplistHelper
  def get_keep_shop_id(rest_id)
    @keep_shop_id = KeepShop.find_by(shop_id: rest_id)&.id
  end
end
