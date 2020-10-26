require 'rails_helper'

RSpec.feature "PostReview", type: :feature do
  scenario "お店に口コミを投稿する" do
    # TOPページにアクセス
    visit root_path

    # 都道府県とカテゴリーを選択
    select '北海道', from: 'pref_code'
    select '居酒屋', from: 'category_code'

    # 検索ボタンをクリック
    click_button "検索"

    # ステータスが成功なのを確認
    expect(page).to have_http_status :ok

    # 遷移先に口コミ投稿フォームがあることを確認
    expect(page).to have_css(".new_review")

    # 遷移先に口コミ欄開閉のreviews__op-clクラスがないことを確認
    expect(page).not_to have_css(".reviews__op-cl")

    # フォームを記入して、投稿ボタンをクリック
    find('#review_shop_id', match: :first, visible: false).set("ha0n303")
    fill_in "review[body]", with: "口コミテスト", match: :first
    click_button "口コミ投稿", match: :first

    expect(page).to have_http_status :ok

    expect(page).to have_text("口コミを見る")

    # 遷移先に口コミ欄開閉のreviews__op-clクラスがあることを確認
    expect(page).to have_css(".reviews__op-cl")

    # 口コミが追加されていることを確認
    within("#review-1") do
      within(".reviews__item") do
        expect(page).to have_content "口コミテスト"
      end
    end
  end
end
