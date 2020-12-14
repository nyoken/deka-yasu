require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:category1) { create(:category) }
  let(:category2) { create(:category2) }
  let!(:emoney1) { create(:emoney, category_id: category1.id) }

  describe 'GET #show' do
    context 'カテゴリーが存在する場合' do
      it 'リクエストが成功する' do
        get category_path(category1)
        expect(response.status).to eq 200
      end

      it 'category1の名前が表示されている' do
        get category_path(category1)
        expect(response.body).to include category1.name
      end

      it 'emoney1の名前が表示されている' do
        get category_path(category1)
        expect(response.body).to include emoney1.name
      end

      it 'category2の名前が表示されていない' do
        get category_path(category1)
        expect(response.body).not_to include category2.name
      end
    end

    context 'カテゴリーが存在しない場合' do
      subject { -> { get category_path(1) } }

      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
