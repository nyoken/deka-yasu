require 'rails_helper'

RSpec.feature "EditUsers", type: :feature do
  # Userを用意
  let(:user) { create(:user) }

  scenario "ユーザー情報編集ページからパスワードを変更し、ログアウト後に新しいパスワードでログインする" do
    login(user, "testuser")
    visit edit_user_path
    fill_in "メールアドレス", with: user.email
    fill_in "現在のパスワード", with: user.password
    fill_in "新しいパスワード", with: "newtestuser"
    fill_in "確認のため、再度新しいパスワードを入力してください", with: "newtestuser"
    click_button "更新"
    expect(page).to have_content "アカウント情報を変更しました。"
    logout
    login(user, "newtestuser")
  end

  scenario "ユーザー情報編集ページから、アカウント削除を拒否し、その後削除する", js: true do
    login(user, "testuser")
    visit edit_user_path
    page.dismiss_confirm do
      click_button "アカウントを削除する"
    end
    page.accept_confirm do
      click_button "アカウントを削除する"
    end
    expect(page).to have_content "アカウントを削除しました。またのご利用をお待ちしております。"
  end
end
