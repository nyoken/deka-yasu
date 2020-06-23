class KeepShop < ApplicationRecord
  has_many :users, through: :user_keep_shops
  has_many :user_keep_shops
end
