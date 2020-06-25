class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, password_length: 7..128


  validates :nickname,:first_name,:first_name_furigana,:last_name,:last_name_furigana,:birthday,  presence: true
  validates :first_name, :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
  validates :first_name_furigana, :last_name_furigana, format: { with: /\A[ァ-ヶー－]+\z/ }
  
  validates :email, format: { with:/\A\S+@\S+\.\S+\z/ }
 
  has_one :address
end
