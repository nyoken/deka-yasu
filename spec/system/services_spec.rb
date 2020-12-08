# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Services', type: :system do
  it 'サービス紹介ページにアクセスできる' do
    # TOPページにアクセス
    visit root_path

    # サービス紹介リンクをクリック
    click_link 'サービス紹介'

    # 遷移先にservice__wrapperクラスがあることを確認
    expect(page).to have_css('.service__wrapper')
  end
end
