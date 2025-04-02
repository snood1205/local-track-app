# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Vendors' do
  describe 'GET /index' do
    let!(:beverage_vendor) { create(:vendor, name: 'Beverage Vendor', category: 'Food & Drinks') }
    let!(:food_vendor) { create(:vendor, name: 'Food Vendor', category: 'Food & Drinks') }
    let!(:merch_vendor) { create(:vendor, name: 'Merch Vendor', category: 'Clothing') }

    before { get '/vendors' }

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.parsed_body).to be_a(Array) }
    it { expect(response.parsed_body.size).to eq(3) }

    %w[name category].each do |attribute|
      it { expect(response.parsed_body[0][attribute]).to eq(beverage_vendor.send(attribute)) }
      it { expect(response.parsed_body[1][attribute]).to eq(food_vendor.send(attribute)) }
      it { expect(response.parsed_body[2][attribute]).to eq(merch_vendor.send(attribute)) }
    end
  end
end
