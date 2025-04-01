# frozen_string_literal: true

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
end
