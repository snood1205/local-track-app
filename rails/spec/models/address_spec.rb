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
end
