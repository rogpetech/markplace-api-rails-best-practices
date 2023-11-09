FactoryBot.define do
  factory :order do
    user
    total { "9.99" }
  end
end
