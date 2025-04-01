# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :track

  validates :street_line1, :city, :country, presence: true
  validates :track_id, uniqueness: true
end
