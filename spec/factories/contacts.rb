FactoryBot.define do
  factory :contact do
    name { 'テスト太郎' }
    tel { '01-2345-6789' }
    email { 'email@email.com' }
    content { 'テスト問い合わせ' }
  end
end
