FactoryBot.define do
  # Userモデルの一例を作成
  factory :user do
    sequence(:email) { |n| "TEST#{n}@example.com" }
    sequence(:username) { |n| "USERNAME#{n}" }
    password { 'testuser' }
    admin { false }
    confirmed_at { Time.now }
  end
end
