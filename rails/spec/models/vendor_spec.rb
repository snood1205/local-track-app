# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vendor do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:track) }
    it { is_expected.to have_many(:menu_items).dependent(:destroy) }
  end
end
