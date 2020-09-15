require 'rails_helper'

RSpec.describe KeepShop, type: :model do
  let(:keep_shop) { build(:keep_shop) }

  describe 'バリデーション' do
    it '全カラムが設定されていればOK' do
      expect(keep_shop.valid?).to eq(true)
    end

    it 'shop_idが空だとNG' do
      keep_shop.shop_id = ''
      expect(keep_shop.valid?).to eq(false)
    end
  end
end
