# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :track

  validates_presence_of :street_line1, :city, :country
  validates_uniqueness_of :track_id, message: 'Only one address is allowed per track.'
end
