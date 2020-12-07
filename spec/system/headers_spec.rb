require 'rails_helper'

RSpec.describe 'Headers', type: :system do
  before do
    visit root_path
  end
  # 各種リンクが正常に動くことを確認
  it 'ロゴからTOPページにアクセスできる' do
    click_link 'ペイつか'
    expect(page).to have_css('.home__wrapper')
  end

  it '「HOME」からTOPページにアクセスできる' do
    click_link 'HOME'
    expect(page).to have_css('.home__wrapper')
  end

  it '「サービス紹介」からサービス紹介ページにアクセスできる' do
    click_link 'サービス紹介'
    expect(page).to have_css('.service__wrapper')
  end

  it '「お問い合わせ」からお問い合わせページにアクセスできる' do
    click_link 'お問い合わせ'
    expect(page).to have_css('.contact__wrapper')
  end

  it '「無料会員登録」から無料会員登録ページにアクセスできる' do
    click_link '無料会員登録', match: :first
    expect(page).to have_css('.register__wrapper')
  end

  it '「ログイン」からログインページにアクセスできる' do
    click_link 'ログイン', match: :first
    expect(page).to have_css('.login__wrapper')
  end
end
