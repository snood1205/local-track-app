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

  describe 'GET /grouped' do
    before { get '/vendors/grouped' }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.parsed_body).to be_a(Hash) }

    it { expect(response.parsed_body.size).to eq(2) }

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
end
