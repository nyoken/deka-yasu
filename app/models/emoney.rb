class Emoney < ApplicationRecord
  validates :name, presence: true
  validates :category, presence: true
  validates :image, presence: true
  validates :link
  validates :description, presence: true
end
