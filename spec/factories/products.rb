FactoryBot.define do
  
  factory :product do
    name              {"iPhoneケース"}
    explanation       {"人気商品です"}
    price             {20000}
    status            {1}
    bear              {1}
    ship_day         {1}
    brand             {"PRADA"}
    category_id       {1}
    shipping_method   {1}
    prefecture_id     {1}
    exhibitor_user_id {1}
    trait :invalid do
      name                  {""}
    end
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
  
    
end