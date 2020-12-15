# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Emoneys', type: :system do
  let(:emoney) { create(:emoney) }

  describe 'index' do
    it 'emoneyの名前が表示されていて、emoney2の名前が表示されていない' do
      emoney
      visit root_path
      click_link '電子マネー'
      expect(current_path).to eq emoney_index_path
      expect(page).to have_content('電子マネー一覧')
      expect(page).to have_content(emoney.name)
      # 画像（emoney.image）が表示されていることを確認
      expect(page).to have_selector("img[src$='image.jpg']")
    end
  end

  describe 'show' do
    before do
      emoney
    end

    it '一覧ページからemoneyの詳細ページに遷移し、詳細情報が表示されている' do
      visit root_path
      click_link '電子マネー'
      click_link emoney.name
      expect(current_path).to eq emoney_path(emoney)
      find('h2') do
        expect(page).to have_content(emoney.name)
      end
      expect(page).to have_selector("img[src$='image.jpg']")
      expect(page).to have_content(emoney.link)
      expect(page).to have_content(emoney.description)
      expect(page).to have_link('編集する')
    end
  end

  describe 'new/create' do
    let(:category) { create(:category) }
    let(:category2) { create(:category2) }

    # トップページ→一覧ページ→emoney作成ページに遷移する
    before do
      category
      category2
      visit root_path
      click_link '電子マネー'
      click_link '電子マネーを追加する'
      expect(current_path).to eq new_emoney_path
      expect(page).to have_content('電子マネー追加')
    end

    context 'emoneyの作成が成功した場合' do
      it 'emoneyを作成し、一覧ページに遷移する' do
        # フォームを記入して、送信ボタンをクリック
        fill_in('emoney[name]', with: 'test_emoney')
        find("#emoney_category_id").find("option[value='#{category.id}']").select_option
        attach_file('emoney[image]', 'spec/fixtures/image.png')
        fill_in('emoney[link]', with: 'test_link')
        fill_in('emoney[description]', with: 'test_description')
        click_button '追加'

        expect(current_path).to eq emoney_index_path
        expect(page).to have_content('電子マネーを追加しました')
        expect(page).to have_link('test_emoney')
      end
    end

    context 'emoneyの作成が失敗した場合' do
      it 'エラーメッセージを表示する' do
        click_button '追加'

        expect(page).to have_content('電子マネーの登録に失敗しました')
        expect(page).to have_content('電子マネー名 が入力されていません。')
        expect(page).to have_content('イメージ画像 が設定されていません。')
        expect(page).to have_content('概要 が入力されていません。')
        expect(page).not_to have_link('test_emoney')
      end
    end
  end

  describe 'update' do
    # emoney更新ページに遷移する
    before do
      emoney
      visit edit_emoney_path(emoney)
      expect(current_path).to eq edit_emoney_path(emoney)
      expect(page).to have_content('電子マネー編集')
    end

    context 'emoneyの更新が成功した場合' do
      it 'emoneyを更新して、emoney詳細ページに遷移する' do
        # 値を変更して、更新ボタンをクリック
        fill_in('emoney[name]', with: 'updated_emoney')
        attach_file('emoney[image]', 'spec/fixtures/image2.png')
        fill_in('emoney[link]', with: 'updated_link')
        fill_in('emoney[description]', with: 'updated_description')
        click_button '更新'

        # 更新後の値が表示され、更新前の値が表示されていない
        expect(current_path).to eq emoney_path(emoney)
        expect(page).to have_content('電子マネー情報を更新しました')
        expect(page).to have_content('updated_emoney')
        expect(page).to have_selector("img[src$='image2.jpg']")
        expect(page).to have_content('updated_link')
        expect(page).to have_content('updated_description')
        expect(page).not_to have_content('test_emoney')
      end
    end

    context 'emoneyの更新が失敗した場合' do
      it 'エラーメッセージを表示して、更新ページに戻る' do
        fill_in('emoney[name]', with: nil)
        click_button '更新'

        # 更新前の値が表示される
        expect(current_path).to eq emoney_path(emoney)
        expect(page).to have_content('電子マネーの更新に失敗しました')
        expect(page).to have_content('電子マネー名 が入力されていません')
      end
    end
  end

  describe 'delete' do
    # emoney詳細ページに遷移する
    before do
      emoney
      visit emoney_path(emoney)
      expect(current_path).to eq emoney_path(emoney)
      find('h2') do
        expect(page).to have_content(emoney.name)
      end
    end

    context 'emoneyの削除が成功した場合' do
      it 'emoneyが削除され、emoney一覧ページに遷移する' do
        click_link '削除する'

        # 一覧ページに遷移し、emoneyの名前が表示されていない
        expect(current_path).to eq emoney_index_path
        expect(page).to have_content('電子マネーを削除しました')
        expect(page).not_to have_content(emoney.name)
      end
    end
  end
end
