# frozen_string_literal: true

FactoryBot.define do
  factory :emoney do
    sequence(:name) { |n| "emoney#{n}" }
    category { 'category' }
    image { 'image' }
    link { 'link' } # null許可
    description { 'description' }
  end
end
