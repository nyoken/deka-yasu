require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { build(:contact) }

  describe 'バリデーションの確認' do
    it '名前、電話番号、メールアドレス、お問い合わせに値が設定されていればOK' do
      expect(contact.valid?).to eq(true)
    end

    it '名前が空だとNG' do
      contact.name = nil
      expect(contact.valid?).to eq(false)
    end

    it '電話番号が空だとNG' do
      contact.tel = nil
      expect(contact.valid?).to eq(false)
    end

    it 'メールアドレスが空だとNG' do
      contact.email = nil
      expect(contact.valid?).to eq(false)
    end

    it 'お問い合わせが空だとNG' do
      contact.content = nil
      expect(contact.valid?).to eq(false)
    end
  end
end
