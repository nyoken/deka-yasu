class KeepShop < ApplicationRecord
  KEEP_SHOP_LIMIT = 10

  has_many :user_keep_shops
  has_many :users, through: :user_keep_shops
end
