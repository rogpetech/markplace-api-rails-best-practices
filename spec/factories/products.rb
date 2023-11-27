FactoryBot.define do
  factory :product do
    title { FFaker::Book.title }
    price { rand * 100 }
    description { FFaker::Book.description }
    published { false }
    user
    quantity { 2 }
  end
end
