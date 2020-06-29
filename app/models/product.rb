class Product < ApplicationRecord
  belongs_to :category
  has_many :product_photos

  enum status: { 新品・未使用: 0, 未使用に近い: 1, 目立った傷や汚れなし: 2, やや傷や汚れあり: 3, 傷や汚れあり: 4, 全体的に状態が悪い: 5 }
  enum bear: { 送料込み（出品者負担）: 0, 着払い（購入者負担）: 1}
  enum ship_day: { １〜２日で発送: 0, ２〜３日で発送: 1, ４〜７日で発送: 2}
end
