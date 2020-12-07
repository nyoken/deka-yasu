# frozen_string_literal: true

class UserKeepShop < ApplicationRecord
  belongs_to :user
  belongs_to :keep_shop
end
