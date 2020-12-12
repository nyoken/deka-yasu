# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Emoneys', type: :request do
  let(:emoney1) { create(:emoney) }
  let(:emoney2) { create(:emoney) }
  let(:emoney_create_params) { attributes_for(:emoney) }
  let(:emoney_update_params) { attributes_for(:emoney, name: 'updated_emoney') }
  let(:invalid_emoney_params) { attributes_for(:emoney, name: '') }

  describe 'GET #index' do
    before do
      emoney1
      emoney2
    end

    it 'リクエストが成功する' do
      get emoney_index_path
      expect(response.status).to eq 200
    end

    it 'emoney1/emoney2の2つが表示されている' do
      get emoney_index_path
      expect(response.body).to include emoney1.name
      expect(response.body).to include emoney2.name
    end
  end

  describe 'GET #show' do
    context '電子マネーが存在する場合' do
      it 'リクエストが成功する' do
        get emoney_path(emoney1)
        expect(response.status).to eq 200
      end

      it 'emoney1の電子マネー名が表示されている' do
        get emoney_path(emoney1)
        expect(response.body).to include emoney1.name
      end

      it 'emoney2の電子マネー名が表示されていない' do
        get emoney_path(emoney1)
        expect(response.body).not_to include emoney2.name
      end
    end

    context '電子マネーが存在しない場合' do
      subject { -> { get emoney_path(1) } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    it 'リクエストが成功する' do
      get new_emoney_path
      expect(response.status).to eq 200
    end
  end

  describe 'GET #edit' do
    before do
      emoney1
    end

    it 'リクエストが成功する' do
      get edit_emoney_path(emoney1)
      expect(response.status).to eq 200
    end

    it '電子マネー名が表示されている' do
      get edit_emoney_path(emoney1)
      expect(response.body).to include emoney1.name
    end

    it 'emoney2の電子マネー名が表示されていない' do
      get edit_emoney_path(emoney1)
      expect(response.body).not_to include emoney2.name
    end
  end

  describe 'POST #create' do
    before do
      emoney1
    end

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功する' do
        post emoney_index_path, params: { emoney: emoney_create_params }
        expect(response.status).to eq 302
      end

      it '電子マネーが登録される' do
        expect do
          post emoney_index_path, params: { emoney: emoney_create_params }
        end.to change(Emoney, :count).by(1)
      end

      it '登録後に電子マネー一覧ページにリダイレクトする' do
        post emoney_index_path, params: { emoney: emoney_create_params }
        expect(response).to redirect_to(emoney_index_path)
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功する' do
        post emoney_index_path, params: { emoney: invalid_emoney_params }
        expect(response.status).to eq 200
      end

      it '電子マネーが登録されない' do
        expect do
          post emoney_index_path, params: { emoney: invalid_emoney_params }
        end.to_not change(Emoney, :count)
      end

      it 'エラーが表示される' do
        post emoney_index_path, params: { emoney: invalid_emoney_params }
        expect(response.body).to include '電子マネーの登録に失敗しました'
      end
    end
  end

  describe 'PUT #update' do
    before do
      emoney1
    end

    context 'パラメータが妥当な場合' do
      it 'リクエストが成功する' do
        put emoney_path(emoney1), params: { emoney: emoney_update_params }
        expect(response.status).to eq 302
      end

      it '電子マネー名が更新される' do
        expect do
          put emoney_path(emoney1), params: { emoney: emoney_update_params }
        end.to change { Emoney.find(emoney1.id).name }.from(emoney1.name).to('updated_emoney')
      end

      it 'リダイレクトする' do
        put emoney_path(emoney1), params: { emoney: emoney_update_params }
        expect(response).to redirect_to Emoney.last
      end
    end

    context 'パラメータが不正な場合' do
      it 'リクエストが成功する' do
        put emoney_path(emoney1), params: { emoney: invalid_emoney_params }
        expect(response.status).to eq 200
      end

      it '電子マネー名が変更されない' do
        expect do
          put emoney_path(emoney1), params: { emoney: invalid_emoney_params }
        end.to_not change(Emoney.find(emoney1.id), :name)
      end

      it 'エラーが表示される' do
        put emoney_path(emoney1), params: { emoney: invalid_emoney_params }
        expect(response.body).to include '電子マネーの更新に失敗しました'
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      emoney1
    end

    it 'リクエストが成功する' do
      delete emoney_path(emoney1)
      expect(response.status).to eq 302
    end

    it '電子マネーが削除される' do
      expect do
        delete emoney_path(emoney1)
      end.to change(Emoney, :count).by(-1)
    end

    it '電子マネー一覧にリダイレクトする' do
      delete emoney_path(emoney1)
      expect(response).to redirect_to(emoney_index_path)
    end
  end
end
