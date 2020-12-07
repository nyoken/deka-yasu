require 'rails_helper'

RSpec.describe 'Users', type: :request do
  # Userを用意
  let(:user) { create(:user) }
  # 正規なパラメータを用意
  let(:user_params) { attributes_for(:user) }
  # 不正なパラメータを用意（emailの値をnilに設定）
  let(:invalid_user_params) { attributes_for(:user, email: nil) }

  # Userのcreateについてのテスト
  describe 'POST #create' do
    context '正規なパラメータの場合' do
      it 'リクエストが成功すること' do
        post register_path, params: { user: user_params }
        # リダイレクトのステータス
        expect(response.status).to eq 302
      end

      it '認証メールが送信されること' do
        post register_path, params: { user: user_params }
        # ActionMailerの送信メール数が1になること
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'createが成功すること' do
        # 正規なパラメータの場合に、User数が1になること
        expect do
          post register_path, params: { user: user_params }
        end.to change(User, :count).by 1
      end

      it 'リダイレクトされること' do
        # 正規なパラメータの場合に、TOPページに遷移すること
        post register_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context '不正なパラメータの場合' do
      it 'リクエストが成功すること' do
        post register_path, params: { user: invalid_user_params }
        # 成功のステータス
        expect(response.status).to eq 200
      end

      it '認証メールが送信されないこと' do
        post register_path, params: { user: invalid_user_params }
        # ActionMailerの送信メール数が0であること
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it 'createが失敗すること' do
        # 不正なパラメータの場合に、User数に変化がないこと
        expect do
          post register_path, params: { user: invalid_user_params }
        end.to_not change(User, :count)
      end

      it 'エラーが表示されること' do
        # 不正なパラメータの場合に、「エラーが発生したため ユーザ は保存されませんでした。」の文言が表示されること
        post register_path, params: { user: invalid_user_params }
        expect(response.body).to include 'エラーがあります。'
      end
    end
  end
end
