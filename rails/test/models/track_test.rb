require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  %w[name length length_unit material].each do |attribute|
    test "validates presence of #{attribute}" do
      track = tracks(:sample)
      track.send "#{attribute}=", nil
      assert_not track.valid?
      assert_includes track.errors[attribute.to_sym], "can't be blank"
    end
  end

  test 'validates that only one row is allowed in the tracks table' do
    track = tracks(:sample)
    track.save
    new_track = track.dup
    assert_not new_track.valid?
    assert_includes new_track.errors[:base], 'Only one row is allowed in this table.'
  end

  test 'validates that length is greater than 0' do
    track = tracks(:sample)
    track.length = -1
    assert_not track.valid?
    assert_includes track.errors[:length], 'must be greater than 0'
  end

  test 'validates that lenght_unit not in the list is denied' do
    track = tracks(:sample)
    track.length_unit = 'invalid_unit'
    assert_not track.valid?
    assert_includes track.errors[:length_unit], 'is not included in the list'
  end

  %w[mi km yd ft m].each do |unit|
    test "validates that permitted unit #{unit} is allowed for lenght_unit" do
      track = tracks(:sample)
      track.length_unit = unit
      assert track.valid?
    end
  end
end
