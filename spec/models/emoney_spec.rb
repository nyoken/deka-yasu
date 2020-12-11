# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Emoney, type: :model do
  let(:emoney) { build(:emoney) }

  describe 'バリデーションの確認' do
    it '全カラムに値が設定されていればOK' do
      expect(emoney.valid?).to eq(true)
    end

    it '名前が空だとNG' do
      emoney.name = nil
      expect(emoney.valid?).to eq(false)
    end

    it 'カテゴリーが空だとNG' do
      emoney.category = nil
      expect(emoney.valid?).to eq(false)
    end

    it 'イメージが空だとNG' do
      emoney.image = nil
      expect(emoney.valid?).to eq(false)
    end

    it '概要が空だとNG' do
      emoney.description = nil
      expect(emoney.valid?).to eq(false)
    end

    it 'リンクが空でもOK' do
      emoney.link = nil
      expect(emoney.valid?).to eq(true)
    end
  end
end
