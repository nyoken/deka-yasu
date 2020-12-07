require 'rails_helper'

RSpec.describe 'PostReview', type: :system do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:admin_user) { create(:user, admin: true) }

  it '未ログインユーザーで、お店に口コミを投稿する' do
    search
    post_review(nil)

    # 口コミが追加されていることを確認
    within('#review-1') do
      expect(page).not_to have_content '削除する'
    end
  end

  it 'ログイン済ユーザーで口コミを投稿し、別ユーザーでも投稿した後、削除する' do
    # userでログインして口コミを投稿
    login(user, 'testuser')
    search
    post_review(user.id, user.username)
    within('#review-1') do
      expect(page).to have_content '削除する'
    end
    logout

    # another_userでログインすると口コミ削除リンクがないことを確認
    login(another_user, 'testuser')
    search
    # 口コミ削除リンクがないことを確認
    within('#review-1') do
      expect(page).not_to have_content '削除する'
    end
    logout

    # 再びuserでログインして口コミを削除
    login(user, 'testuser')
    search
    click_on '削除する'

    # 口コミが削除されていることを確認
    expect(page).not_to have_css('.reviews__op-cl')
  end

  it '管理者ユーザーで、お店に口コミを投稿して削除する' do
    # userでログインして口コミを投稿
    login(user, 'testuser')
    search
    post_review(user.id, user.username)
    within('#review-1') do
      expect(page).to have_content '削除する'
    end
    logout

    # admin_userでログインして口コミが削除できることを確認
    login(admin_user, 'testuser')
    search
    within('#review-1') do
      expect(page).to have_content '削除する'
    end
    click_on '削除する'

    expect(page).not_to have_text('口コミを見る')
  end
end
