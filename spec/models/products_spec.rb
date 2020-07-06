require 'rails_helper'

RSpec.describe Product do
  let(:user){create(:user)}
  let(:category){create(:category)}
  describe '#create' do
    it "全て揃っている時出品できる" do
      product = build(:product, category_id: category.id, exhibitor_user_id: user.id )
      product.product_photos.build
      expect(product).to be_valid
    end

    it "photoが空だと出品できない" do
      product = build(:product, category_id: category.id, exhibitor_user_id: user.id)
      product.valid?
      expect(product.errors[:product_photos]).to include("を入力してください")
    end

    it "nameが空だと出品できない" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "explanationが空だと出品できない" do
      product = build(:product, explanation: "")
      product.valid?
      expect(product.errors[:explanation]).to include("を入力してください")
    end

    it "priceが300円未満だと出品できない" do
      product = build(:product, price: 299)
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "priceが9,999,999円より高い場合は出品できない" do
      product = build(:product, price: "10000000")
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "priceが数値じゃない場合は出品できない" do
      product = build(:product, price: "あああ")
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "nameが40字を越えている場合は出品できない" do
      product = build(:product, name: "a" * 41)
      product.valid?
      expect(product.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "explanationが1000字を超えている場合は出品できない " do
      product = build(:product, explanation: "a" * 1001)
      product.valid?
      expect(product.errors[:explanation]).to include("は1000文字以内で入力してください")
    end
  end

  describe '#update' do
    it "全て揃っている時出品できる" do
      product = build(:product, category_id: category.id, exhibitor_user_id: user.id )
      product.product_photos.build
      expect(product).to be_valid
    end

    it "photoが空だと出品できない" do
      product = build(:product, category_id: category.id, exhibitor_user_id: user.id)
      product.valid?
      expect(product.errors[:product_photos]).to include("を入力してください")
    end

    it "nameが空だと出品できない" do
      product = build(:product, name: nil)
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end

    it "explanationが空だと出品できない" do
      product = build(:product, explanation: "")
      product.valid?
      expect(product.errors[:explanation]).to include("を入力してください")
    end

    it "priceが300円未満だと出品できない" do
      product = build(:product, price: 299)
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "priceが9,999,999円より高い場合は出品できない" do
      product = build(:product, price: "10000000")
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "priceが数値じゃない場合は出品できない" do
      product = build(:product, price: "あああ")
      product.valid?
      expect(product.errors[:price]).to include("は一覧にありません")
    end

    it "nameが40字を越えている場合は出品できない" do
      product = build(:product, name: "a" * 41)
      product.valid?
      expect(product.errors[:name]).to include("は40文字以内で入力してください")
    end

    it "explanationが1000字を超えている場合は出品できない " do
      product = build(:product, explanation: "a" * 1001)
      product.valid?
      expect(product.errors[:explanation]).to include("は1000文字以内で入力してください")
    end
  end

end