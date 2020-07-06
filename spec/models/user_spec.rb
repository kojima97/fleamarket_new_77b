require 'rails_helper'

describe User do
  describe '#create' do
    it 'is valid' do
      user = build(:user)
      user.valid?
      expect(user).to be_valid
    end

    it "nicknameがなければ登録出来ないこと" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end

    it "passwordがなければ登録出来ないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it " passwordが6文字以下であれば登録できないこと " do
      user = build(:user, password: "00000", password_confirmation: "00000")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it " 重複したemailが存在する場合は登録できないこと " do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    

    it "生年月日がなければ登録出来ないこと" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end

    it "苗字がなければ登録出来ないこと" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("は不正な値です")
    end

    it "苗字(ふりがな)がなければ登録出来ないこと" do
      user = build(:user, last_name_furigana: "")
      user.valid?
      expect(user.errors[:last_name_furigana]).to include("は不正な値です")
    end

    it "名前がなければ登録出来ないこと" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("は不正な値です")
    end

    it "名前(ふりがな)がなければ登録出来ないこと" do
      user = build(:user, first_name_furigana: "")
      user.valid?
      expect(user.errors[:first_name_furigana ]).to include("は不正な値です")
    end
     # パスワードが７文字以上で登録ができる
     it "is vaild with a password that has more than 7 characters" do
      user = build(:user, password: "1111111", password_confirmation: "1111111")
      user.valid?
      expect(user).to be_valid
    end

    

    # 氏名は全角で入力でしているか
    it "is valid with a first_name entered full-width" do
      user = build(:user, first_name: "ぁ-んァ-ン一-龥")
      user.valid?
      expect(user).to be_valid
    end

    # 名前は全角で入力でしているか
    it "is valid with a last_name entered full-width" do
      user = build(:user, last_name: "ぁ-んァ-ン一-龥")
      user.valid?
      expect(user).to be_valid
    end

    # 氏名(カナ)は全角で入力でしているか
    it "is valid with a first_name_kana entered full-width" do
      user = build(:user, first_name_furigana: "ヤマダ")
      user.valid?
      expect(user).to be_valid
    end

    # 名前(カナ)は全角で入力でしているか
    it "is valid with a last_name_kana entered full-width" do
      user = build(:user, last_name_furigana: "タロウ")
      user.valid?
      expect(user).to be_valid
    end

    # ＠を含んで使用しているか
    it "is valid with a email that includes @" do
      user = build(:user, email: "aaa@aaa.jp")
      user.valid?
      expect(user).to be_valid
    end
    # ドメインを含んで使用しているか
    it "is valid with a email that includes ne.jp" do
      user = build(:user, email: "aaa@aaa.ne.jp")
      user.valid?
      expect(user).to be_valid
    end

    # ドメインを含んで使用しているか
    it "is valid with a email that includes com" do
      user = build(:user, email: "aaa@aaa.com")
      user.valid?
      expect(user).to be_valid
    end
      
  end
end