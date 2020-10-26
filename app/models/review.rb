class Review < ApplicationRecord
  validates :shop_id, presence: true
  validates :body, presence: true
end
