# frozen_string_literal: true

class User < ApplicationRecord
  has_many :user_keep_shops, dependent: :destroy
  has_many :keep_shops, through: :user_keep_shops
  has_many :reviews, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  # お気に入りに追加
  def like(keep_shop)
    user_keep_shops.find_or_create_by(keep_shop_id: keep_shop.id)
  end

  # お気に入りに削除
  def unlike(keep_shop)
    user_keep_shops.find_by(keep_shop_id: keep_shop)&.destroy
  end
end
