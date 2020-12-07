# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:review) { build(:review) }

  describe 'バリデーション' do
    it '全カラムが設定されていればOK' do
      expect(review.valid?).to eq(true)
    end

    it 'shop_idが空だとNG' do
      review.shop_id = ''
      expect(review.valid?).to eq(false)
    end

    it 'bodyが空だとNG' do
      review.body = ''
      expect(review.valid?).to eq(false)
    end
  end
end
