# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tracks' do
  let!(:track) { create(:track) }
  let!(:address) { create(:address, track:) }

  describe 'GET /tracks/info' do
    before do
      get '/tracks/info'
    end

    describe 'HTTP response' do
      it { expect(response).to have_http_status(:ok) }
    end

    describe 'Track information' do
      let(:parsed_track) { response.parsed_body['track'] }

      it { expect(parsed_track['name']).to eq(track.name) }
      # to_s is used because decimals are serialized as strings in JSON
      it { expect(parsed_track['length']).to eq(track.length.to_s) }
      it { expect(parsed_track['length_unit']).to eq(track.length_unit) }
      it { expect(parsed_track['human_readable_length']).to eq("#{track.length} #{track.length_unit}") }
      it { expect(parsed_track['material']).to eq(track.material) }
      it { expect(parsed_track['address']).to be_present }
    end

    describe 'address information' do
      let(:parsed_address) { response.parsed_body['track']['address'] }

      it { expect(parsed_address['street_line1']).to eq(address.street_line1) }
      it { expect(parsed_address['street_line2']).to eq(address.street_line2) }
      it { expect(parsed_address['city']).to eq(address.city) }
      it { expect(parsed_address['region']).to eq(address.region) }
      it { expect(parsed_address['postal_code']).to eq(address.postal_code) }
      it { expect(parsed_address['country']).to eq(address.country) }
    end
  end
end
