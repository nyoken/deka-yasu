require 'rails_helper'

RSpec.describe "Shops", type: :request do
  describe "GET /shops" do
    context "大枠での絞り込み" do
      it '県とカテゴリーでの絞り込みができる' do
        get shops_path, params: { pref_code: "PREF01", category_code: "RSFST09000" }
        expect(response.status).to eq 200

        # 札幌駅が表示されていることを確認
        within("#areacode_s") do
          expect(response.body).to include '札幌駅'
        end

        # PREF01（北海道）, category_code: RSFST11000（イタリアン） の店が取得されない
        expect(response.body).not_to include 'Italian×Spanish グラニタ'
        # PREF13（東京）, category_code: RSFST09000（居酒屋） の店が取得されない
        expect(response.body).not_to include 'くいもの屋わん 銀座店'
      end
    end

    context "詳細条件での絞り込み" do
      it 'エリアでの絞り込みができる' do
        # 室蘭エリアで絞り込む
        get shops_path, params: {
          pref_code: "PREF01",
          areacode_s: "AREAS5909",
          breakfast: 0,
          lunch: 0,
          midnight: 0,
          buffet: 0,
          bottomless_cup: 0,
          bottomless_cup: 0,
          no_smoking: 0
        }

        expect(response.status).to eq 200
        # PREF01（北海道）, area_code: AREAS5708（苫小牧） の店が取得されない
        expect(response.body).not_to include '甘太郎 苫小牧店'
      end

      it 'ラジオボタンによる絞り込み' do
        get shops_path, params: {
          pref_code: "PREF01",
          areacode_s: "AREAS5502",
          breakfast: 0,
          lunch: 0,
          midnight: 0,
          buffet: 0,
          bottomless_cup: 0,
          bottomless_cup: 0,
          no_smoking: 1
        }
        expect(response.status).to eq 200
        # PREF01（北海道）, area_code: AREAS5502（札幌駅） no_smoking: 1（喫煙席あり）の店が取得される
        expect(response.body).to include '隠れ家個室居酒屋 楓（かえで） 札幌駅前店'
        # PREF01（北海道）, area_code: AREAS5502（札幌駅） no_smoking: 0（喫煙席なし）の店が取得される
        expect(response.body).not_to include '海鮮和食 個室居酒屋 世海 すすきの店'
      end

      it '条件に一致するお店がない場合' do
        get shops_path, params: {
          pref_code: "PREF01",
          areacode_s: "AREAS5502",
          breakfast: 1,
          lunch: 1,
          midnight: 1,
          buffet: 1,
          bottomless_cup: 1,
          bottomless_cup: 1,
          no_smoking: 1
        }
        expect(response.status).to eq 200
        # PREF01（北海道）, area_code: AREAS5502（札幌駅） の店が取得される
        expect(response.body).to include '条件に一致するお店がありません。再度検索をお願いします。'
      end
    end
  end
end
