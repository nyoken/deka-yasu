require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { build(:category) }

  describe 'バリデーションの確認' do
    it '名前に値が設定されていればOK' do
      expect(category.valid?).to eq(true)
    end

    it '名前が空だとNG' do
      category.name = nil
      expect(category.valid?).to eq(false)
    end
  end
end
