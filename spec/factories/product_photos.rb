FactoryBot.define do

  factory :product_photo do
    photo         {File.open("#{Rails.root}/public/images/sample.3.jpg")}
    product_id    {1}
  end
  
end