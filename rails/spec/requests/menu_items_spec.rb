# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'MenuItems' do
  subject(:menu_item) { create(:menu_item) }

  describe 'GET /items/:id' do
    context 'when the menu item exists' do
      before { get "/items/#{menu_item.slug}" }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.content_type).to start_with('application/json') }
      it { expect(response.parsed_body).to include('name' => menu_item.name) }
      it { expect(response.parsed_body).to include('description' => menu_item.description) }
      it { expect(response.parsed_body).to include('price' => menu_item.price) }
    end

    context 'when the menu item does not exist' do
      before { get '/items/non-existing-slug' }

      it { expect(response).to have_http_status(:not_found) }
      it { expect(response.content_type).to start_with('application/json') }
      it { expect(response.parsed_body).to include('error' => 'Menu item not found') }
    end
  end
end
