# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /' do
    it 'ルートページで県情報・カテゴリー情報が取得できている' do
      get root_path
      # PREF01（北海道）, PREF47（沖縄）の値が取得される
      expect(response.body).to include '北海道'
      expect(response.body).to include '沖縄'
      # RSFST09000（居酒屋）, RSFST90000（その他の料理）の値が取得される
      expect(response.body).to include '居酒屋'
      expect(response.body).to include 'その他の料理'
      expect(response.status).to eq 200
    end
  end
end
