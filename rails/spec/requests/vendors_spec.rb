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
    let!(:water) { create(:menu_item, name: 'Water', vendor: beverage_vendor) }
    let!(:soda) { create(:menu_item, name: 'Soda', vendor: beverage_vendor) }
    let!(:juice) { create(:menu_item, name: 'Juice', vendor: beverage_vendor) }
    let!(:burger) { create(:menu_item, name: 'Burger', vendor: food_vendor) }
    let!(:fries) { create(:menu_item, name: 'Fries', vendor: food_vendor) }
    let!(:tshirt) { create(:menu_item, name: 'T-shirt', vendor: merch_vendor) }

    before { get '/vendors/grouped/include-menu' }

    include_examples 'grouped vendor info'

    it { expect(response.parsed_body['Food & Drinks'][0]['menu']).to be_a(Array) }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'].size).to eq(3) }
    it { expect(response.parsed_body['Food & Drinks'][1]['menu']).to be_a(Array) }
    it { expect(response.parsed_body['Food & Drinks'][1]['menu'].size).to eq(2) }
    it { expect(response.parsed_body['Clothing'][0]['menu']).to be_a(Array) }
    it { expect(response.parsed_body['Clothing'][0]['menu'].size).to eq(1) }

    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][0]['name']).to eq(water.name) }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][1]['name']).to eq(soda.name) }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][2]['name']).to eq(juice.name) }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][0]['price']).to eq(water.price) }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][1]['price']).to eq(soda.price) }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][2]['price']).to eq(juice.price) }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][0]['description']).to eq(burger.description) }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][1]['description']).to eq(fries.description) }
    it { expect(response.parsed_body['Clothing'][0]['menu'][0]['description']).to eq(tshirt.description) }

    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][0]).not_to have_key('id') }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][0]).not_to have_key('vendorId') }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][0]).not_to have_key('createdAt') }
    it { expect(response.parsed_body['Food & Drinks'][0]['menu'][0]).not_to have_key('updatedAt') }
  end
end
