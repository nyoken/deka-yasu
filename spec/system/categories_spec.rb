# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  let(:admin_user) { create(:user, admin: true) }
  let(:category1) { create(:category) }
  let(:category2) { create(:category, name: "category2") }
  let(:emoney1) { create(:emoney, category: category1) }
  let(:emoney2) { create(:emoney, category: category2) }

  describe 'show' do
    before do
      category1
      category2
      emoney1
    end

    it '一覧ページからcategoryの詳細ページに遷移し、詳細情報が表示されている' do
      visit root_path
      click_link '電子マネー紹介'
      click_link category1.name
      expect(current_path).to eq category_path(category1)
      find('h2') do
        expect(page).to have_content(category1.name)
      end
      expect(page).to have_selector("img[src$='image.jpg']")
      # category1のリンクはないが、category2のリンクはある
      expect(page).not_to have_link(category1.name)
      expect(page).to have_link(category2.name)
    end
  end

  describe 'new/create' do
    before do
      login(admin_user, 'testuser')
      category1
      click_link 'カテゴリー追加'
      expect(current_path).to eq new_category_path
      expect(page).to have_content('カテゴリー追加')
      expect(page).to have_link(category1.name)
    end

    context 'categoryの作成が成功した場合' do
      it 'categoryを作成し、トップページに遷移する' do
        # フォームを記入して、送信ボタンをクリック
        fill_in('category[name]', with: 'test_category')
        click_button '追加'

        expect(current_path).to eq root_path
        expect(page).to have_content('カテゴリーを追加しました')
        click_link 'カテゴリー追加'
        expect(page).to have_link('test_category')
      end
    end

    context 'categoryの作成が失敗した場合' do
      it 'エラーメッセージを表示する' do
        click_button '追加'

        expect(page).to have_content('カテゴリーの登録に失敗しました')
        expect(page).to have_content('カテゴリー名 が入力されていません。')
        click_link 'カテゴリー追加'
        expect(page).not_to have_link('test_emoney')
      end
    end
  end

  describe 'edit/update' do
    before do
      login(admin_user, 'testuser')
      category1
      click_link 'カテゴリー追加'
      click_link category1.name
      expect(current_path).to eq edit_category_path(category1)
      expect(page).to have_content('カテゴリー編集')
      find('h5') do
        expect(page).to have_content(category1.name)
      end
      expect(page).to have_link('カテゴリーを削除する')
      expect(page).to have_link(category1.name)
    end

    context 'categoryの更新が成功した場合' do
      it 'categoryを更新して、ルートページに遷移する' do
        # 値を変更して、更新ボタンをクリック
        fill_in('category[name]', with: 'updated_category')
        click_button '更新'

        # 更新後の値が表示され、更新前の値が表示されていない
        expect(current_path).to eq root_path
        click_link 'カテゴリー追加'
        expect(page).to have_link('updated_category')
        expect(page).not_to have_link('category1')
      end
    end

    context 'categoryの更新が失敗した場合' do
      it 'エラーメッセージを表示して、更新ページに戻る' do
        fill_in('category[name]', with: nil)
        click_button '更新'

        # 更新前の値が表示される
        expect(current_path).to eq category_path(category1)
        expect(page).to have_content('カテゴリーの更新に失敗しました')
        expect(page).to have_content('カテゴリー名 が入力されていません')
      end
    end
  end

  describe 'delete' do
    # category編集ページに遷移する
    before do
      login(admin_user, 'testuser')
      category1
      visit edit_category_path(category1)
    end

    context 'categoryの削除が成功した場合' do
      it 'categoryが削除され、ルートページに遷移する' do
        click_link 'カテゴリーを削除する'

        # トップページに遷移し、カテゴリー追加ページにcategory1の名前が表示されていない
        expect(current_path).to eq root_path
        expect(page).to have_content('カテゴリーを削除しました')
        expect(page).not_to have_content(category1.name)
      end
    end
  end
end
