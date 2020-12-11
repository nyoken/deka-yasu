# frozen_string_literal: true

class Emoney < ApplicationRecord
  validates :name, presence: true
  validates :category, presence: true
  validates :image, presence: true
  validate :link
  validates :description, presence: true

  mount_uploader :image, ImageUploader
end
