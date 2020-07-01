FactoryBot.define do
  # Userモデルの一例を作成
  factory :user do
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
  end
end
