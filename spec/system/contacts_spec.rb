require 'rails_helper'

RSpec.feature "Contacts", type: :system do
  scenario "お問い合わせページから問い合わせを作成する" do
    # TOPページにアクセス
    visit root_path

    # お問い合わせリンクをクリック
    click_link "お問い合わせ"

    # ステータスが成功なのを確認
    expect(page).to have_http_status :ok

    # 遷移先にcontact__wrapperクラスがあることを確認
    expect(page).to have_css(".contact__wrapper")

    # フォームを記入して、送信ボタンをクリック
    fill_in "例）ペイつか太郎", with: "テスト太郎"
    fill_in "例）01-2345-6789", with: "01-2345-6789"
    fill_in "例）pay@tsuka.com", with: "email@email.com"
    fill_in "できるだけ詳細にご記入ください", with: "テスト問い合わせ"
    click_button "送信"

    # 遷移先にフォームの内容があることを確認して、送信ボタンをクリック
    expect(page).to have_content("確認画面")
    expect(page).to have_content("テスト太郎")
    expect(page).to have_content("01-2345-6789")
    expect(page).to have_content("email@email.com")
    expect(page).to have_content("テスト問い合わせ")
    click_button "送信"

    # 送信完了画面に遷移することを確認
    expect(page).to have_content("お問い合わせ送信完了")
  end
end
