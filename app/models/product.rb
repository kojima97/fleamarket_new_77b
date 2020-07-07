class Product < ApplicationRecord
  validates_associated :product_photos
  validates :name, presence: true, length: { maximum: 40 }
  validates :explanation, presence: true, length: { maximum: 1000 }
  validates :category_id, :status, :bear, :ship_day, presence: true
  validates :price,presence: true, inclusion: 300..9999999
  validates :product_photos, presence: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :category
  has_many :product_photos, dependent: :destroy
  
  accepts_nested_attributes_for :product_photos, allow_destroy: true
  
  # validates :category_id, presence: ture 


  enum status: { 新品・未使用: 0, 未使用に近い: 1, 目立った傷や汚れなし: 2, やや傷や汚れあり: 3, 傷や汚れあり: 4, 全体的に状態が悪い: 5 }
  enum bear: { 送料込み（出品者負担）: 0, 着払い（購入者負担）: 1}
  enum ship_day: { １〜２日で発送: 0, ２〜３日で発送: 1, ４〜７日で発送: 2}
  enum shipping_method: { 未定: 0, クロネコヤマト: 1, ゆうパック: 2, ゆうメール: 3}
end
