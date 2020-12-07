module SearchMacros
  def search
    # TOPページにアクセス
    visit root_path

    # 都道府県とカテゴリーを選択
    select '北海道', from: 'pref_code'
    select '居酒屋', from: 'category_code'

    # 検索ボタンをクリック
    click_button '検索'
  end
end
