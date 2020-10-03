require 'rails_helper'

RSpec.feature "EditUsers", type: :feature do
  background do
    ActionMailer::Base.deliveries.clear
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  let(:user) { create(:user) }
  scenario "パスワード再設定ページでパスワードを変更し、変更後のパスワードでログインする" do
    visit new_user_password_path
    fill_in "メールアドレス", with: user.email
    expect { click_button "送信" }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content "パスワードの再設定について数分以内にメールでご連絡いたします。"

    # 送信されたメールのURLを取得してアクセスし、メールアドレスが確認できたことを確認
    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url

    fill_in "新しいパスワード", with: "newtestuser"
    fill_in "確認のため、再度新しいパスワードを入力してください", with: "newtestuser"
    click_button "再設定"
    expect(page).to have_content "パスワードが正しく変更されました。"
    logout
    login(user, "newtestuser")
  end
end
