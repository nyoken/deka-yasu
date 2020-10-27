class Review < ApplicationRecord
  belongs_to :user, optional: true

  validates :shop_id, presence: true
  validates :body, presence: true
  validates :user_id, presence: true, allow_nil: true
end
