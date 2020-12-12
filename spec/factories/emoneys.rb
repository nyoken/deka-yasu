# frozen_string_literal: true

FactoryBot.define do
  factory :emoney do
    sequence(:name) { |n| "emoney#{n}" }
    category { 'category' }
    image {  Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image.png'), 'image/png') }
    link { 'link' }
    description { 'description' }
  end
end
