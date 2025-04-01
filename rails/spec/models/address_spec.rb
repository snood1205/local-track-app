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

  describe '#to_s' do
    context 'when all address fields are present' do
      subject(:address) { build(:address, :full) }

      it { expect(address.to_s).to eq("123 Main St, Apt 1A\nAnytown, New Any\nANY123\nAnywhere") }
    end
  end
end
