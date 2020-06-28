require 'rails_helper'

RSpec.feature "Services", type: :feature do
  scenario "サービス紹介ページにアクセスできる" do
    # TOPページにアクセス
    visit root_path

    # サービス紹介リンクをクリック
    click_link "サービス紹介"

    # ステータスが成功なのを確認
    expect(page).to have_http_status :ok

    # 遷移先にservice__wrapperクラスがあることを確認
    expect(page).to have_css(".service__wrapper")
  end
end
