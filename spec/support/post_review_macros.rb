module PostReviewMacros
  def post_review(user_id, body="口コミテスト")
    # フォームを記入して、投稿ボタンをクリック
    expect(page).to have_css("#review_user_id", visible: false)
    page.find('#review_user_id', match: :first, visible: false).set(user_id)
    page.find('#review_shop_id', match: :first, visible: false).set("ha0n303")
    fill_in "review[body]", with: body, match: :first
    click_button "口コミ投稿", match: :first

    expect(page).to have_text("口コミを見る")

    # 遷移先に口コミ欄開閉のreviews__op-clクラスがあることを確認
    expect(page).to have_css(".reviews__op-cl")
  end
end
