# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vendor do
  subject(:vendor) { create(:vendor) }

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
  end

  describe 'associations' do
    it { is_expected.to belong_to(:track) }
    it { is_expected.to have_many(:menu_items).dependent(:destroy) }
  end

  describe '#menu' do
    context 'when the menu is empty' do
      it { expect(vendor.menu).to be_empty }
    end

    context 'when the menu has an item without a heading' do
      let!(:menu_item) { create(:menu_item, vendor:, heading: nil) }

      it 'returns the menu item in the * grouping' do
        expect(vendor.menu).to eq({ '*' => [{ 'description' => menu_item.description, 'name' => menu_item.name,
                                              'price' => menu_item.price, 'slug' => menu_item.slug }] })
      end
    end

    context 'when the menu has items without headings' do
      let!(:pizza) { create(:menu_item, :pizza, vendor:, heading: nil) }
      let!(:popcorn) { create(:menu_item, :popcorn, vendor:, heading: nil) }

      it 'returns the menu items grouped by heading' do
        expect(vendor.menu).to eq({ '*' => [
                                    { 'description' => pizza.description, 'name' => pizza.name, 'price' => pizza.price,
                                      'slug' => pizza.slug }, { 'description' => popcorn.description, 'name' => popcorn.name, 'price' => popcorn.price, 'slug' => popcorn.slug }
                                  ] })
      end
    end

    context 'when the menu has an item with a heading' do
      let!(:soda) { create(:menu_item, :soda, vendor:, heading: 'Beverages') }

      it 'returns the menu item in the correct heading grouping' do
        expect(vendor.menu).to eq({ 'Beverages' => [{ 'description' => soda.description, 'name' => soda.name, 'price' => soda.price,
                                                      'slug' => soda.slug }] })
      end

      it 'does not include the * grouping as there are no items without headings' do
        expect(vendor.menu).not_to have_key('*')
      end
    end

    context 'when the menu has multiple items with the same heading' do
      let!(:soda) { create(:menu_item, :soda, vendor:, heading: 'Beverages') }
      let!(:water) { create(:menu_item, :water, vendor:, heading: 'Beverages') }

      it 'returns the menu items grouped by heading' do
        expect(vendor.menu).to eq({ 'Beverages' => [
                                    { 'description' => soda.description, 'name' => soda.name, 'price' => soda.price,
                                      'slug' => soda.slug }, { 'description' => water.description, 'name' => water.name, 'price' => water.price, 'slug' => water.slug }
                                  ] })
      end

      it 'does not include the * grouping as there are no items without headings' do
        expect(vendor.menu).not_to have_key('*')
      end
    end

    context 'when there are is one item per headings but all having headings' do
      let!(:soda) { create(:menu_item, :soda, vendor:, heading: 'Beverages') }
      let!(:pizza) { create(:menu_item, :pizza, vendor:, heading: 'Food') }

      it 'returns the menu items grouped by heading' do
        expect(vendor.menu).to eq({
                                    'Beverages' => [{ 'description' => soda.description, 'name' => soda.name, 'price' => soda.price,
                                                      'slug' => soda.slug }], 'Food' => [{ 'description' => pizza.description, 'name' => pizza.name, 'price' => pizza.price, 'slug' => pizza.slug }]
                                  })
      end

      it 'does not include the * grouping as there are no items without headings' do
        expect(vendor.menu).not_to have_key('*')
      end
    end

    context 'when there are multiple headings with multiple items' do
      let!(:soda) { create(:menu_item, :soda, vendor:, heading: 'Beverages') }
      let!(:water) { create(:menu_item, :water, vendor:, heading: 'Beverages') }
      let!(:pizza) { create(:menu_item, :pizza, vendor:, heading: 'Food') }
      let!(:popcorn) { create(:menu_item, :popcorn, vendor:, heading: 'Food') }

      it 'returns the menu items grouped by heading' do
        expect(vendor.menu).to eq({
                                    'Beverages' => [{ 'description' => soda.description, 'name' => soda.name, 'price' => soda.price, 'slug' => soda.slug },
                                                    { 'description' => water.description, 'name' => water.name, 'price' => water.price,
                                                      'slug' => water.slug }], 'Food' => [{ 'description' => pizza.description, 'name' => pizza.name, 'price' => pizza.price, 'slug' => pizza.slug }, { 'description' => popcorn.description, 'name' => popcorn.name, 'price' => popcorn.price, 'slug' => popcorn.slug }]
                                  })
      end

      it 'does not include the * grouping as there are no items without headings' do
        expect(vendor.menu).not_to have_key('*')
      end
    end

    context 'when there are multiple headings with one item and an item without a heading' do
      let!(:soda) { create(:menu_item, :soda, vendor:, heading: 'Beverages') }
      let!(:pizza) { create(:menu_item, :pizza, vendor:, heading: 'Food') }
      let!(:sunscreen) { create(:menu_item, :sunscreen, vendor:, heading: nil) }

      it 'returns the menu items grouped by heading' do
        expect(vendor.menu).to eq({
                                    'Beverages' => [{ 'description' => soda.description, 'name' => soda.name, 'price' => soda.price,
                                                      'slug' => soda.slug }], 'Food' => [{ 'description' => pizza.description, 'name' => pizza.name, 'price' => pizza.price, 'slug' => pizza.slug }], '*' => [{ 'description' => sunscreen.description, 'name' => sunscreen.name, 'price' => sunscreen.price, 'slug' => sunscreen.slug }]
                                  })
      end
    end

    context 'when there are multiple headings with multiple items and an item without a heading' do
      let!(:soda) { create(:menu_item, :soda, vendor:, heading: 'Beverages') }
      let!(:water) { create(:menu_item, :water, vendor:, heading: 'Beverages') }
      let!(:pizza) { create(:menu_item, :pizza, vendor:, heading: 'Food') }
      let!(:popcorn) { create(:menu_item, :popcorn, vendor:, heading: 'Food') }
      let!(:sunscreen) { create(:menu_item, :sunscreen, vendor:, heading: nil) }

      it 'returns the menu items grouped by heading' do
        expect(vendor.menu).to eq({ 'Beverages' => [{ 'description' => soda.description, 'name' => soda.name, 'price' => soda.price, 'slug' => soda.slug }, { 'description' => water.description, 'name' => water.name, 'price' => water.price, 'slug' => water.slug }],
                                    'Food' => [
                                      { 'description' => pizza.description, 'name' => pizza.name, 'price' => pizza.price,
                                        'slug' => pizza.slug }, { 'description' => popcorn.description, 'name' => popcorn.name, 'price' => popcorn.price, 'slug' => popcorn.slug }
                                    ],
                                    '*' => [{ 'description' => sunscreen.description, 'name' => sunscreen.name,
                                              'price' => sunscreen.price, 'slug' => sunscreen.slug }] })
      end
    end

    context 'when there are multiple headings with multiple items and multiple items without a heading' do
      let!(:soda) { create(:menu_item, :soda, vendor:, heading: 'Beverages') }
      let!(:water) { create(:menu_item, :water, vendor:, heading: 'Beverages') }
      let!(:pizza) { create(:menu_item, :pizza, vendor:, heading: 'Food') }
      let!(:popcorn) { create(:menu_item, :popcorn, vendor:, heading: 'Food') }
      let!(:sunscreen) { create(:menu_item, :sunscreen, vendor:, heading: nil) }
      let!(:ear_plugs) { create(:menu_item, vendor:, heading: nil, name: 'Ear plugs', slug: 'ear-plugs') }

      it 'returns the menu items grouped by heading' do
        expect(vendor.menu).to eq(
          { 'Beverages' => [
              { 'description' => soda.description, 'name' => soda.name, 'price' => soda.price, 'slug' => soda.slug },
              { 'description' => water.description, 'name' => water.name, 'price' => water.price, 'slug' => water.slug }
            ],
            'Food' => [
              { 'description' => pizza.description, 'name' => pizza.name, 'price' => pizza.price,
                'slug' => pizza.slug },
              { 'description' => popcorn.description, 'name' => popcorn.name, 'price' => popcorn.price,
                'slug' => popcorn.slug }
            ],
            '*' => [
              { 'description' => sunscreen.description, 'name' => sunscreen.name, 'price' => sunscreen.price,
                'slug' => sunscreen.slug },
              { 'description' => ear_plugs.description, 'name' => ear_plugs.name, 'price' => ear_plugs.price,
                'slug' => ear_plugs.slug }
            ] }
        )
      end
    end
  end
end
