require 'rails_helper'

describe Address do
  describe '#create_address' do

    it "prefecture_idがなければ登録出来ないこと" do
      address = build(:address, prefecture_id: "")
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end

    it "cityがなければ登録出来ないこと" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end

    it "postal_codeがなければ登録出来ないこと" do
      address = build(:address, postal_code: "")
      address.valid?
      expect(address.errors[:postal_code]).to include("を入力してください")
    end

    it "otherがなければ登録出来ないこと" do
      address = build(:address, other: "")
      address.valid?
      expect(address.errors[:other]).to include("を入力してください")
    end
    

    
    
    # 郵便番号が半角数字のみの場合登録できる
    it "郵便番号が半角数字のみの場合登録できる" do
      address = build(:address, postal_code: "1111111")
      address.valid?
      expect(address).to be_valid
    end
  end
end