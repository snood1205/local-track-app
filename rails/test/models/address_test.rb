# frozen_string_literal: true

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  %w[street_line1 city country].each do |attribute|
    test "validates presence of #{attribute}" do
      address = addresses(:sample)
      address.send "#{attribute}=", nil
      assert_not address.valid?
      assert_includes address.errors[attribute.to_sym], "can't be blank"
    end
  end

  test 'validates that only one address is allowed per track' do
    track = tracks(:sample)
    track.save
    new_address = Address.new(track: track)
    assert_not new_address.valid?
    assert_includes new_address.errors[:track_id], 'Only one address is allowed per track.'
  end
end
