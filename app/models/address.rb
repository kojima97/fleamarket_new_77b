class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user, optional: true
  validates :postal_code, format: { with:/\A[0-9]+\z/ }
  validates :city,:other,:postal_code,:prefecture_id,  presence: true
  
end
