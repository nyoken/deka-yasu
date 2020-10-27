module PostReviewMacros
  def post_review(user_id)
    # フォームを記入して、投稿ボタンをクリック
    find('#review_user_id', match: :first, visible: false).set(user_id)
    find('#review_shop_id', match: :first, visible: false).set("ha0n303")
    fill_in "review[body]", with: "口コミテスト", match: :first
    click_button "口コミ投稿", match: :first

    expect(page).to have_http_status :ok

    expect(page).to have_text("口コミを見る")

    # 遷移先に口コミ欄開閉のreviews__op-clクラスがあることを確認
    expect(page).to have_css(".reviews__op-cl")
  end
end
