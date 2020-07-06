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
  end
    
end