# frozen_string_literal: true

class Emoney < ApplicationRecord
  validates :name, presence: true
  validates :image, presence: true
  validate :link
  validates :description, presence: true

  belongs_to :category

  mount_uploader :image, ImageUploader
end
