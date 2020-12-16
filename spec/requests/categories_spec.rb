require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, admin: true) }
  let(:category1) { create(:category) }
  let(:category2) { create(:category2) }
  let(:category_create_params) { attributes_for(:category) }
  let(:category_update_params) { attributes_for(:category, name: 'updated_category') }
  let(:invalid_category_params) { attributes_for(:category, name: '') }

  shared_context '未ログイン・一般ユーザーでアクセスできないことをチェック' do
    context 'ログインしていない場合' do
      it 'リクエストが成功しない' do
        expect(response.status).to eq 302
      end

      it 'トップページにリダイレクトする' do
        expect(response).to redirect_to(root_path)
      end
    end

    context '一般ユーサーでログインしている場合' do
      before do
        sign_in user
      end

      it 'リクエストが成功しない' do
        expect(response.status).to eq 302
      end

      it 'トップページにリダイレクトする' do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'GET #show' do
    context 'カテゴリーが存在する場合' do
      before do
        category1
        category2
      end

      it 'リクエストが成功する' do
        get category_path(category1)
        expect(response.status).to eq 200
      end

      it 'category1の名前が取得されている' do
        get category_path(category1)
        expect(response.body).to include category1.name
      end

      it 'category1の名前が取得されている' do
        get category_path(category1)
        expect(response.body).to include category1.name
      end

      it 'category2の名前も取得されている' do
        get category_path(category1)
        expect(response.body).to include category2.name
      end
    end

    context 'カテゴリーが存在しない場合' do
      subject { -> { get category_path(1) } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end

  describe 'GET #new' do
    before do
      category1
      category2
      get new_category_path
    end

    include_context '未ログイン・一般ユーザーでアクセスできないことをチェック'

    context '管理者ユーサーでログインしている場合' do
      before do
        sign_in admin_user
        get new_category_path
      end

      it 'リクエストが成功する' do
        expect(response.status).to eq 200
      end

      it 'category1の名前が取得できている' do
        expect(response.body).to include category1.name
      end

      it 'category2の名前が取得できている' do
        expect(response.body).to include category2.name
      end
    end
  end

  describe 'GET #edit' do
    before do
      category1
      category2
      get edit_category_path(category1)
    end

    include_context '未ログイン・一般ユーザーでアクセスできないことをチェック'

    context '管理者ユーサーでログインしている場合' do
      before do
        sign_in admin_user
      end

      it 'リクエストが成功する' do
        get edit_category_path(category1)
        expect(response.status).to eq 200
      end

      it 'category1が取得できている' do
        get edit_category_path(category1)
        expect(response.body).to include category1.name
      end

      it 'category2の電子マネー名が取得できている' do
        get edit_category_path(category1)
        expect(response.body).to include category2.name
      end
    end
  end

  describe 'POST #create' do
    before do
      post category_index_path, params: { category: category_create_params }
    end

    include_context '未ログイン・一般ユーザーでアクセスできないことをチェック'

    context '管理者ユーサーでログインしている場合' do
      before do
        sign_in admin_user
      end

      context 'パラメータが妥当な場合' do
        it 'リクエストが成功する' do
          post category_index_path, params: { category: category_create_params }
          expect(response.status).to eq 302
        end

        it '電子マネーが登録される' do
          expect do
            post category_index_path, params: { category: category_create_params }
          end.to change(Category, :count).by(1)
        end

        it '登録後に電子マネー一覧ページにリダイレクトする' do
          post category_index_path, params: { category: category_create_params }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'パラメータが不正な場合' do
        it 'リクエストが成功する' do
          post category_index_path, params: { category: invalid_category_params }
          expect(response.status).to eq 200
        end

        it '電子マネーが登録されない' do
          expect do
            post category_index_path, params: { category: invalid_category_params }
          end.to_not change(Category, :count)
        end

        it 'エラーが表示される' do
          post category_index_path, params: { category: invalid_category_params }
          expect(response.body).to include 'カテゴリーの登録に失敗しました'
        end
      end
    end
  end

  describe 'PUT #update' do
    before do
      category1
      put category_path(category1), params: { category: category_update_params }
    end

    include_context '未ログイン・一般ユーザーでアクセスできないことをチェック'

    context '管理者ユーサーでログインしている場合' do
      before do
        sign_in admin_user
      end

      context 'パラメータが妥当な場合' do
        it 'リクエストが成功する' do
          put category_path(category1), params: { category: category_update_params }
          expect(response.status).to eq 302
        end

        it '電子マネー名が更新される' do
          expect do
            put category_path(category1), params: { category: category_update_params }
          end.to change { Category.find(category1.id).name }.from(category1.name).to('updated_category')
        end

        it 'リダイレクトする' do
          put category_path(category1), params: { category: category_update_params }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'パラメータが不正な場合' do
        it 'リクエストが成功する' do
          put category_path(category1), params: { category: invalid_category_params }
          expect(response.status).to eq 200
        end

        it '電子マネー名が変更されない' do
          expect do
            put category_path(category1), params: { category: invalid_category_params }
          end.to_not change(Category.find(category1.id), :name)
        end

        it 'エラーが表示される' do
          put category_path(category1), params: { category: invalid_category_params }
          expect(response.body).to include 'カテゴリーの更新に失敗しました'
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      category1
      delete category_path(category1)
    end

    include_context '未ログイン・一般ユーザーでアクセスできないことをチェック'

    context '管理者ユーサーでログインしている場合' do
      before do
        sign_in admin_user
      end
            
      it 'リクエストが成功する' do
        delete category_path(category1)
        expect(response.status).to eq 302
      end

      it '電子マネーが削除される' do
        expect do
          delete category_path(category1)
        end.to change(Category, :count).by(-1)
      end

      it '電子マネー一覧にリダイレクトする' do
        delete category_path(category1)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
