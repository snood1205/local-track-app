# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Track do
  describe 'validations' do
    %i[name length length_unit material].each do |attribute|
      it { is_expected.to validate_presence_of(attribute) }
    end

    describe 'validating that only one row is allowed in the tracks table' do
      before do
        create(:track)
        new_track.valid?
      end

      after { described_class.destroy_all }

      let(:new_track) { build(:track) }

      it { expect(new_track).not_to be_valid }
      it { expect(new_track.errors[:base]).to include('Only one row is allowed in this table.') }
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
end
