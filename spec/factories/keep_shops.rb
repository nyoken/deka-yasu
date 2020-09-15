FactoryBot.define do
  factory :keep_shop do
    sequence(:shop_id) { |n| "SHOP_ID#{n}" }
  end
end
