FactoryBot.define do

  factory :category do
  ancestry {nil}
  name {'レディース'}
  
    factory :child_category do |f|
      f.name {"ssss"}
  
      factory :grand_category do |g|
        g.name {"ddddd"}
      end
      
    end 
  end
end