# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Track do
  describe 'validations' do
    %i[name length length_unit material].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end

    describe 'validating that length is greater than 0' do
      let(:negative_length) { build(:track, length: -1) }

      before { negative_length.valid? }

      it { expect(negative_length).not_to be_valid }

      it { expect(negative_length.errors[:length]).to include('must be greater than 0') }
    end

    describe 'unit validation' do
      let(:invalid_unit) { build(:track, length_unit: 'invalid_unit') }

      before { invalid_unit.valid? }

      it { expect(invalid_unit).not_to be_valid }
      it { expect(invalid_unit.errors[:length_unit]).to include('is not included in the list') }

      %w[mi km yd ft m].each do |unit|
        let(:valid_unit) { build(:track, length_unit: unit) }
        it { expect(valid_unit).to be_valid }
      end
    end
  end

  describe 'allows multiple tracks to be created' do
    let(:clay_track) { build(:track) }
    let(:asphalt_track) { build(:track, name: 'Other Track', length: 0.5, length_unit: 'mi', material: 'Asphalt') }

    it 'does not raise an error when saving multiple tracks' do
      expect do
        clay_track.save!
        asphalt_track.save!
      end.not_to raise_error
    end

    context 'when trying to save multiple tracks' do
      before do
        clay_track.save!
        asphalt_track.save!
      end

      it { expect(clay_track).to be_valid }
      it { expect(asphalt_track).to be_valid }
      it { expect(described_class.count).to eq(2) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_one(:address).dependent(:destroy) }
    it { is_expected.to have_many(:vendors).dependent(:destroy) }
  end
end
