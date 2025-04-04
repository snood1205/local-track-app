# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenuItem do
  subject(:menu_item) { create(:menu_item) }

  describe 'associations' do
    it { is_expected.to belong_to(:vendor) }
  end

  describe 'validations' do
    before { described_class.skip_callback(:validation, :before, :generate_slug) }
    after { described_class.set_callback(:validation, :before, :generate_slug) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:slug) }
    it { is_expected.to validate_uniqueness_of(:slug).case_insensitive }
    it { is_expected.to validate_length_of(:slug).is_at_most(28) }
    it { is_expected.to allow_value('valid-slug').for(:slug) }
    it { is_expected.not_to allow_value('invalid slug').for(:slug) }
    it { is_expected.not_to allow_value('INVALID-SLUG').for(:slug) }
    it { is_expected.not_to allow_value('invalid_slug').for(:slug) }
    it { is_expected.not_to allow_value('invalid-slug!').for(:slug) }
    it { is_expected.not_to allow_value('inval!d-slug').for(:slug) }
    it { is_expected.to validate_presence_of(:price_in_cents) }
    it { is_expected.to validate_numericality_of(:price_in_cents).only_integer.is_greater_than_or_equal_to(0) }
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
