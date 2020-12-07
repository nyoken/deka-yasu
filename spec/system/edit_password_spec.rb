# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'EditPassword', type: :system do
  # Userを用意
  let(:user) { create(:user) }

  it 'パスワード編集ページからパスワードを変更し、ログアウト後に新しいパスワードでログインする' do
    login(user, 'testuser')
    visit change_password_path
    fill_in 'メールアドレス', with: user.email
    fill_in '現在のパスワード', with: user.password
    fill_in '新しいパスワード', with: 'newtestuser'
    fill_in '確認のため、再度新しいパスワードを入力してください', with: 'newtestuser'
    click_button '更新'
    expect(page).to have_content 'アカウント情報を変更しました。'
    logout
    login(user, 'newtestuser')
  end
end
