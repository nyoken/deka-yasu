# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Contacts', type: :request do
  # contactを用意
  let(:contact) { create(:contact) }
  # 正規なパラメータを用意
  let(:contact_params) { attributes_for(:contact) }
  # 不正なパラメータを用意（emailの値をnilに設定）
  let(:invalid_contact_params) { attributes_for(:contact, email: nil) }

  describe 'GET #new' do
    it 'リクエストが成功すること' do
      get contact_path
      expect(response.status).to eq 200
    end
  end

  # contactのcreateについてのテスト
  describe 'POST #create' do
    context '正規なパラメータの場合' do
      it 'リクエストが成功すること' do
        post create_contact_path, params: { contact: contact_params }
        # リダイレクトのステータス
        expect(response.status).to eq 200
      end

      it '問い合わせ者、管理者の2人に確認メールが送信されること' do
        post create_contact_path, params: { contact: contact_params }
        # ActionMailerの送信メール数が1になること
        expect(ActionMailer::Base.deliveries.size).to eq 2
      end

      it 'createが成功すること' do
        # contact数が1になること
        expect do
          post create_contact_path, params: { contact: contact_params }
        end.to change(Contact, :count).by 1
      end

      it '完了画面に遷移すること' do
        post create_contact_path, params: { contact: contact_params }
        expect(response.body).to include 'お問い合わせ送信完了'
      end
    end

    context '不正なパラメータの場合' do
      it 'リクエストが成功すること' do
        post create_contact_path, params: { contact: invalid_contact_params }
        # 成功のステータス
        expect(response.status).to eq 200
      end

      it '認証メールが送信されないこと' do
        post create_contact_path, params: { contact: invalid_contact_params }
        # ActionMailerの送信メール数が0であること
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it 'createが失敗すること' do
        # 不正なパラメータの場合に、contact数に変化がないこと
        expect do
          post create_contact_path, params: { contact: invalid_contact_params }
        end.to_not change(Contact, :count)
      end

      it '作成画面に遷移すること' do
        post create_contact_path, params: { contact: invalid_contact_params }
        expect(response.body).to include '以下を全てご記入の上、送信ボタンを押してください。'
      end

      it 'エラーが表示されること' do
        # 不正なパラメータの場合に、「エラーが発生したため ユーザ は保存されませんでした。」の文言が表示されること
        post create_contact_path, params: { contact: invalid_contact_params }
        expect(response.body).to include 'エラーがあります。'
      end
    end
  end
end
