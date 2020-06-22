FactoryBot.define do

  factory :address do
    prefecture_id             {1}
    city                      {"横浜市港北区"}
    postal_code               {"00000000"}
    other                     {"日吉"}

  end
end