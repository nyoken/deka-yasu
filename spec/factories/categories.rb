FactoryBot.define do
  factory :category, class: Category do
    name { "category1" }
  end

  factory :category2, class: Category do
    name { "category2" }
  end
end
