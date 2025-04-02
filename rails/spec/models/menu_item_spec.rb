# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenuItem do
  describe 'associations' do
    it { is_expected.to belong_to(:vendor) }
  end

  describe '#price' do
    let(:menu_item) { build(:menu_item, price_in_cents: 1234) }

    it 'returns the price formatted with currency' do
      expect(menu_item.price).to eq('$12.34')
    end
  end

  describe '#to_h' do
    let(:menu_item) { build(:menu_item) }

    it 'returns a hash representation of the menu item' do
      expect(menu_item.to_h).to eq(
        name: menu_item.name,
        description: menu_item.description,
        price: menu_item.price
      )
    end
  end
end
