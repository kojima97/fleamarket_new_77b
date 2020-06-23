FactoryBot.define do

  factory :user do
    id                     {"1"}
    nickname               {"taro"}
    email                  {"kkk@gmail.com"}
    password               {"1111111"}
    password_confirmation  {"1111111"}
    first_name             {"太郎"}
    first_name_furigana    {"タロウ"}
    last_name              {"山田"}
    last_name_furigana     {"ヤマダ"}
    birthday               {"19900925"}
    tel_number             {"0000000000"}
  end
  
end 