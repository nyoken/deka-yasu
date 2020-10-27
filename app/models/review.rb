class Review < ApplicationRecord
  belongs_to :user
  
  validates :shop_id, presence: true
  validates :body, presence: true
end
