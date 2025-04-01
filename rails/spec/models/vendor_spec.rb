# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vendor do
  subject(:vendor) { build(:vendor) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:track) }
    it { is_expected.to have_many(:menu_items).dependent(:destroy) }
  end

  describe '#menu' do
    context 'when the menu is empty' do
      it { expect(vendor.menu).to be_empty }
    end

    context 'when the menu has items without a category' do
      let(:menu_item) { build(:menu_item, vendor:, category: nil) }

      it 'returns the menu items' do
        expect(vendor.menu).to \
          equal({ '*' => [
                  { name: menu_item.name, description: menu_item.description,
                    price: menu_item.price }
                ] })
      end
    end
  end
end
