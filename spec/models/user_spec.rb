require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe "バリデーションの確認" do
    it "email、password、password_confirmationに値が設定されていればOK" do
      expect(@user.valid?).to eq(true)
    end

    it "メールアドレスが空だとNG" do
      @user.email = nil
      expect(@user.valid?).to eq(false)
      expect(@user.errors[:email]).to include("が入力されていません。")
    end

    it "@がないなどメールアドレスが不正な場合NG" do
      @user.email = "test"
      expect(@user.valid?).to eq(false)
      expect(@user.errors[:email]).to include("は有効でありません。")
    end

    it "パスワードが空だとNG" do
      @user.password = nil
      expect(@user.valid?).to eq(false)
      expect(@user.errors[:password]).to include("が入力されていません。")
    end

    it "パスワードが短すぎる場合に会員登録できない" do
      @user.password = "pass"
      expect(@user.valid?).to eq(false)
      expect(@user.errors[:password]).to include("は6文字以上に設定して下さい。")
    end

    it "パスワードが暗号化されているか" do
      expect(@user.encrypted_password).to_not eq @user.password
    end

    it "passwordとpassword_confirmationが異なる場合NG" do
      @user.password_confirmation = "passward"
      expect(@user.valid?).to eq(false)
      expect(@user.errors[:password_confirmation]).to include("がパスワードと一致しません。")
    end
  end
end