# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Vendors' do
  let!(:beverage_vendor) { create(:vendor, name: 'Drink stand', slug: 'drink-stand', category: 'Food & Drinks') }
  let!(:food_vendor) { create(:vendor, name: 'Food Vendor', slug: 'food-vendor', category: 'Food & Drinks') }
  let!(:merch_vendor) { create(:vendor, name: 'Merch Vendor', slug: 'merch-vendor', category: 'Clothing') }

  describe 'GET /index' do
    before { get '/vendors' }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.parsed_body).to be_a(Array) }
    it { expect(response.parsed_body.size).to eq(3) }

    %w[name category].each do |attribute|
      it { expect(response.parsed_body[0][attribute]).to eq(beverage_vendor.send(attribute)) }
      it { expect(response.parsed_body[1][attribute]).to eq(food_vendor.send(attribute)) }
      it { expect(response.parsed_body[2][attribute]).to eq(merch_vendor.send(attribute)) }
    end

    it { expect(response.parsed_body[0]).not_to have_key('id') }
    it { expect(response.parsed_body[0]).not_to have_key('trackId') }
    it { expect(response.parsed_body[0]).not_to have_key('createdAt') }
    it { expect(response.parsed_body[0]).not_to have_key('updatedAt') }
  end

  shared_examples 'grouped vendor info' do
    it { expect(response).to have_http_status(:ok) }
    it { expect(response.parsed_body).to be_a(Hash) }

    it { expect(response.parsed_body['Food & Drinks']).to be_a(Array) }
    it { expect(response.parsed_body['Food & Drinks'].size).to eq(2) }

    it { expect(response.parsed_body['Food & Drinks'][0]['name']).to eq(beverage_vendor.name) }
    it { expect(response.parsed_body['Food & Drinks'][0]['slug']).to eq(beverage_vendor.slug) }
    it { expect(response.parsed_body['Food & Drinks'][0]).not_to have_key('id') }
    it { expect(response.parsed_body['Food & Drinks'][1]['slug']).to eq(food_vendor.slug) }
    it { expect(response.parsed_body['Food & Drinks'][1]).not_to have_key('id') }

    it { expect(response.parsed_body['Clothing']).to be_a(Array) }
    it { expect(response.parsed_body['Clothing'].size).to eq(1) }
    it { expect(response.parsed_body['Clothing'][0]).not_to have_key('id') }
    it { expect(response.parsed_body['Clothing'][0]['slug']).to eq(merch_vendor.slug) }

    it { expect(response.parsed_body['Food & Drinks'][0]).not_to have_key('category') }
    it { expect(response.parsed_body['Food & Drinks'][0]).not_to have_key('trackId') }
    it { expect(response.parsed_body['Food & Drinks'][0]).not_to have_key('createdAt') }
    it { expect(response.parsed_body['Food & Drinks'][0]).not_to have_key('updatedAt') }
  end

  describe 'GET /grouped' do
    before { get '/vendors/grouped' }

    include_examples 'grouped vendor info'
  end

  describe 'GET /vendors/grouped/include-menu' do
    let!(:water) { create(:menu_item, heading: 'Drinks', name: 'Water', vendor: beverage_vendor) }
    let!(:soda) { create(:menu_item,  heading: 'Drinks', name: 'Soda', vendor: beverage_vendor) }
    let!(:juice) { create(:menu_item,  heading: 'Drinks', name: 'Juice', vendor: beverage_vendor) }
    let!(:burger) { create(:menu_item, heading: 'Sandwiches', name: 'Burger', vendor: food_vendor) }
    let!(:fries) { create(:menu_item, heading: 'Snacks', name: 'Fries', vendor: food_vendor) }
    let!(:tshirt) { create(:menu_item, name: 'T-shirt', vendor: merch_vendor) }
    let(:parsed_beverage_vendor) { response.parsed_body[beverage_vendor.category][0] }
    let(:parsed_food_vendor) { response.parsed_body[food_vendor.category][1] }
    let(:parsed_merch_vendor) { response.parsed_body[merch_vendor.category][0] }
    let(:lc) { ->(heading) { heading.camelize(:lower) } }

    before { get '/vendors/grouped/include-menu' }

    include_examples 'grouped vendor info'

    it { expect(response.parsed_body[beverage_vendor.category]).to be_a(Array) }
    it { expect(response.parsed_body[beverage_vendor.category].size).to eq(2) }
    it { expect(response.parsed_body[merch_vendor.category]).to be_a(Array) }
    it { expect(response.parsed_body[merch_vendor.category].size).to eq(1) }

    it { expect(parsed_beverage_vendor).to be_a(Hash) }
    it { expect(parsed_food_vendor).to be_a(Hash) }
    it { expect(parsed_merch_vendor).to be_a(Hash) }

    it { expect(parsed_beverage_vendor['menu'][lc[water.heading]]).to be_a(Array) }
    it { expect(parsed_beverage_vendor['menu'][lc[water.heading]][0]).to be_a(Hash) }

    it { expect(parsed_beverage_vendor['menu'][lc[water.heading]][0]['name']).to eq(water.name) }
    it { expect(parsed_beverage_vendor['menu'][lc[water.heading]][0]['description']).to eq(water.description) }
    it { expect(parsed_beverage_vendor['menu'][lc[water.heading]][0]['price']).to eq(water.price) }
    it { expect(parsed_beverage_vendor['menu'][lc[soda.heading]][1]['name']).to eq(soda.name) }
    it { expect(parsed_beverage_vendor['menu'][lc[soda.heading]][1]['description']).to eq(soda.description) }
    it { expect(parsed_beverage_vendor['menu'][lc[soda.heading]][1]['price']).to eq(soda.price) }
    it { expect(parsed_beverage_vendor['menu'][lc[juice.heading]][2]['name']).to eq(juice.name) }
    it { expect(parsed_beverage_vendor['menu'][lc[juice.heading]][2]['description']).to eq(juice.description) }
    it { expect(parsed_beverage_vendor['menu'][lc[juice.heading]][2]['price']).to eq(juice.price) }
    it { expect(parsed_food_vendor['menu'][lc[burger.heading]][0]['name']).to eq(burger.name) }
    it { expect(parsed_food_vendor['menu'][lc[burger.heading]][0]['description']).to eq(burger.description) }
    it { expect(parsed_food_vendor['menu'][lc[burger.heading]][0]['price']).to eq(burger.price) }
    it { expect(parsed_food_vendor['menu'][lc[fries.heading]][0]['name']).to eq(fries.name) }
    it { expect(parsed_food_vendor['menu'][lc[fries.heading]][0]['description']).to eq(fries.description) }
    it { expect(parsed_food_vendor['menu'][lc[fries.heading]][0]['price']).to eq(fries.price) }
    it { expect(parsed_merch_vendor['menu'][lc[tshirt.heading]][0]['name']).to eq(tshirt.name) }
    it { expect(parsed_merch_vendor['menu'][lc[tshirt.heading]][0]['description']).to eq(tshirt.description) }
    it { expect(parsed_merch_vendor['menu'][lc[tshirt.heading]][0]['price']).to eq(tshirt.price) }

    it { expect(parsed_beverage_vendor['menu'][lc[water.heading]][0]).not_to have_key('id') }
    it { expect(parsed_beverage_vendor['menu'][lc[water.heading]][0]).not_to have_key('vendorId') }
    it { expect(parsed_beverage_vendor['menu'][lc[water.heading]][0]).not_to have_key('createdAt') }
    it { expect(parsed_beverage_vendor['menu'][lc[water.heading]][0]).not_to have_key('updatedAt') }
  end
end
