# frozen_string_literal: true

module PostReviewMacros
  def post_review(user_id, username = 'ゲスト', body = '口コミテスト')
    # 遷移先に口コミ投稿フォームがあることを確認
    expect(page).to have_css('.new_review')

    # 遷移先に口コミ欄開閉のreviews__op-clクラスがないことを確認
    expect(page).not_to have_css('.reviews__op-cl')

    # フォームを記入して、投稿ボタンをクリック
    find('#review_user_id', match: :first, visible: false).set(user_id)
    find('#review_shop_id', match: :first, visible: false).set('ha0n303')
    fill_in 'review[body]', with: body, match: :first
    click_button '口コミ投稿', match: :first

    # 口コミが追加されていることを確認
    expect(page).to have_text('口コミを見る')
    expect(page).to have_css('.reviews__op-cl')
    within('#review-1') do
      expect(page).to have_content(username)
      expect(page).to have_content(body)
    end
  end
end
