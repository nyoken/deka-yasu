require 'rails_helper'

RSpec.feature "PostReview", type: :feature do
  let(:user) { create(:user) }

  scenario "未ログインユーザーで、お店に口コミを投稿する" do
    search

    # 遷移先に口コミ投稿フォームがあることを確認
    expect(page).to have_css(".new_review")

    # 遷移先に口コミ欄開閉のreviews__op-clクラスがないことを確認
    expect(page).not_to have_css(".reviews__op-cl")

    # フォームを記入して、投稿ボタンをクリック
    find('#review_user_id', match: :first, visible: false).set(nil)
    find('#review_shop_id', match: :first, visible: false).set("ha0n303")
    fill_in "review[body]", with: "未ログイン口コミ", match: :first
    click_button "口コミ投稿", match: :first

    expect(page).to have_http_status :ok

    expect(page).to have_text("口コミを見る")

    # 遷移先に口コミ欄開閉のreviews__op-clクラスがあることを確認
    expect(page).to have_css(".reviews__op-cl")

    # 口コミが追加されていることを確認
    within("#review-1") do
      within(".reviews__user") do
        expect(page).to have_content "ゲスト"
      end
      within(".reviews__body") do
        expect(page).to have_content "未ログイン口コミ"
      end
    end
  end

  scenario "ログイン済ユーザーで、お店に口コミを投稿する" do
    login(user, "testuser")
    search

    # 遷移先に口コミ投稿フォームがあることを確認
    expect(page).to have_css(".new_review")

    # 遷移先に口コミ欄開閉のreviews__op-clクラスがないことを確認
    expect(page).not_to have_css(".reviews__op-cl")

    # フォームを記入して、投稿ボタンをクリック
    find('#review_user_id', match: :first, visible: false).set(user.id)
    find('#review_shop_id', match: :first, visible: false).set("ha0n303")
    fill_in "review[body]", with: "ログイン済口コミ", match: :first
    click_button "口コミ投稿", match: :first

    expect(page).to have_http_status :ok

    expect(page).to have_text("口コミを見る")

    # 遷移先に口コミ欄開閉のreviews__op-clクラスがあることを確認
    expect(page).to have_css(".reviews__op-cl")

    # 口コミが追加されていることを確認
    within("#review-1") do
      within(".reviews__user") do
        expect(page).to have_content user.username
      end
      within(".reviews__body") do
        expect(page).to have_content "ログイン済口コミ"
      end
    end
  end
end
