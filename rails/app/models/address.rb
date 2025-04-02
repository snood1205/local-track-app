# frozen_string_literal: false

# Information about a track's address.
class Address < ApplicationRecord
  belongs_to :track

  validates :street_line1, :city, :country, presence: true
  validates :track_id, uniqueness: true

  def as_json(*)
    super(
      only: %i[street_line1 street_line2 city region postal_code country],
      methods: :track_id
    )
  end

  def to_s
    ''.tap do |address|
      address << street_line1
      address << present_or_newline(street_line2)
      address << city
      address << present_or_newline(region)
      address << "#{postal_code}\n" if postal_code.present?
      address << country
    end
  end

  private

  def present_or_newline(value) = value.present? ? ", #{value}\n" : "\n"
end
