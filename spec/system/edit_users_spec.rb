# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'EditUsers', type: :system do
  # Userを用意
  let(:user) { create(:user) }

  it 'ユーザー情報編集ページからメールアドレスを変更する' do
    login(user, 'testuser')
    visit edit_user_path
    fill_in 'メールアドレス', with: 'newTEST@example.com'
    fill_in 'ユーザーネーム', with: user.username
    fill_in 'パスワード', with: user.password
    click_button '変更'
    expect(page).to have_content 'アカウント情報を変更しました。'
    logout
  end

  it 'ユーザー情報編集ページからユーザーネームを変更する' do
    login(user, 'testuser')
    visit edit_user_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'ユーザーネーム', with: 'newUSERNAME'
    fill_in 'パスワード', with: user.password
    click_button '変更'
    expect(page).to have_content 'アカウント情報を変更しました。'
    logout
  end

  it 'ユーザー情報編集ページから、アカウント削除を拒否し、その後削除する' do
    login(user, 'testuser')
    visit edit_user_path
    click_on 'アカウントを削除する'
    expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
  end
end
