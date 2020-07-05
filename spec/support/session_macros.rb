module SessionMacros
  def login(user, password)
    visit login_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: password
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"
  end

  def logout
    click_link "ログアウト", match: :first
    expect(page).to have_content "ログアウトしました。"
  end
end
