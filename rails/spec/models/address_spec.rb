# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  subject(:address) { build(:address) }

  describe 'validations' do
    %i[street_line1 city country].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end

    it { is_expected.to validate_uniqueness_of(:track_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:track) }
  end

  describe '#to_s' do
    context 'when all address fields are present' do
      subject(:address) { build(:address, :full) }

      it { expect(address.to_s).to eq("123 Main St, Apt 1A\nAnytown, New Any\nANY123\nAnywhere") }
    end

    context 'when only minimal address fields are present' do
      subject(:address) { build(:address, :minimal) }

      it { expect(address.to_s).to eq("123 Main St\nAnytown\nAnywhere") }
    end

    context 'when street line 2 is there' do
      subject(:address) { build(:address, :minimal, street_line2: 'Apt 1A') }

      it { expect(address.to_s).to eq("123 Main St, Apt 1A\nAnytown\nAnywhere") }
    end

    context 'when postal code is there' do
      subject(:address) { build(:address, :minimal, postal_code: 'ANY123') }

      it { expect(address.to_s).to eq("123 Main St\nAnytown\nANY123\nAnywhere") }
    end

    context 'when region is there' do
      subject(:address) { build(:address, :minimal, region: 'New Any') }

      it { expect(address.to_s).to eq("123 Main St\nAnytown, New Any\nAnywhere") }
    end

    context 'when street line 2 and region are there' do
      subject(:address) { build(:address, :minimal, street_line2: 'Apt 1A', region: 'New Any') }

      it { expect(address.to_s).to eq("123 Main St, Apt 1A\nAnytown, New Any\nAnywhere") }
    end

    context 'when street line 2 and postal code are there' do
      subject(:address) { build(:address, :minimal, street_line2: 'Apt 1A', postal_code: 'ANY123') }

      it { expect(address.to_s).to eq("123 Main St, Apt 1A\nAnytown\nANY123\nAnywhere") }
    end

    context 'when region and postal code are there' do
      subject(:address) { build(:address, :minimal, region: 'New Any', postal_code: 'ANY123') }

      it { expect(address.to_s).to eq("123 Main St\nAnytown, New Any\nANY123\nAnywhere") }
    end
  end
end
