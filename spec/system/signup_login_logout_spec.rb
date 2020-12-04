require 'rails_helper'

RSpec.feature "SingupLoginLogout", type: :feature do
  background do
    ActionMailer::Base.deliveries.clear
  end

  def extract_confirmation_url(mail)
    body = mail.body.encoded
    body[/http[^"]+/]
  end

  scenario "サインアップ後にログインし、ログアウトする" do
    # TOPページにアクセス
    visit root_path

    # ステータスが成功なのを確認
    expect(page).to have_http_status :ok

    # 無料会員ボタンをクリック
    click_link "無料会員登録", match: :first

    # 遷移先にregister__wrapperクラスがあることを確認
    expect(page).to have_css('.register__wrapper')

    # フォームを記入
    fill_in "メールアドレス", with: "email@example.com"
    fill_in "パスワード", with: "password"
    fill_in "確認のため、再度パスワードを入力してください", with: "password"

    # 会員登録時にメール送信されたことを確認
    expect { click_button "無料会員登録" }.to change { ActionMailer::Base.deliveries.size }.by(1)
    expect(page).to have_content "本人確認用のメールを送信しました。メール内のリンクからアカウントを有効化させてください。"

    # 送信されたメールのURLを取得してアクセスし、メールアドレスが確認できたことを確認
    mail = ActionMailer::Base.deliveries.last
    url = extract_confirmation_url(mail)
    visit url
    expect(page).to have_content "メールアドレスが確認できました。"

    # ログイン成功を確認
    fill_in "メールアドレス", with: "email@example.com"
    fill_in "パスワード", with: "password"
    click_button "ログイン"
    expect(page).to have_content "ログインしました。"

    # ログアウト成功を確認
    click_link "ログアウト", match: :first
    expect(page).to have_content "ログアウトしました。"
  end
end
