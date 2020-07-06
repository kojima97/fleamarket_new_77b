require 'rails_helper'

describe CreditCard do

  let(:user){create(:user)}
  let(:creditcard){create(:creditcard)}

  describe '#create' do

    it 'customer_idがない時は保存されないこと' do
      creditcard = CreditCard.new(customer_id: "", card_id: "111", user_id: "111")
      creditcard.valid?
      expect(creditcard.errors[:customer_id]).to include("を入力してください")
    end

    it 'card_idがない時は保存されないこと' do
      creditcard = CreditCard.new(customer_id: "111", card_id: "", user_id: "111")
      creditcard.valid?
      expect(creditcard.errors[:card_id]).to include("を入力してください")
    end
    
    it 'user_idがない時は保存されないこと' do
      creditcard = CreditCard.new(customer_id: "111", card_id: "111", user_id: "")
      creditcard.valid?
      expect(creditcard.errors[:user_id]).to include("を入力してください")
    end

    
  end
end