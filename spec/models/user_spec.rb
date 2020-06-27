require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end

  describe 'バリデーションの確認' do
    it 'email、password、password_confirmationに値が設定されていればOK' do
      expect(@user.valid?).to eq(true)
    end

    it 'emailが空だとNG' do
      @user.email = nil
      expect(@user.valid?).to eq(false)
      expect(@user.errors[:email]).to include("が入力されていません。")
    end

    it 'passwordが空だとNG' do
      @user.password = nil
      expect(@user.valid?).to eq(false)
      expect(@user.errors[:password]).to include("が入力されていません。")
    end

    it "メールアドレスが重複しているとNG" do
      user = create(:user, email: "taro@example.com")
      expect(build(:user, email: user.email)).to_not be_valid
    end

    it "パスワードが暗号化されているか" do
      expect(@user.encrypted_password).to_not eq @user.password
    end

    it "passwordとpassword_confirmationが異なる場合NG" do
      expect(build(:user,password:"password",password_confirmation: "passward")).to_not be_valid
    end
  end
end
