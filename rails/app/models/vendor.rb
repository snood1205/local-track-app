# frozen_string_literal: true

class Vendor < ApplicationRecord
  belongs_to :track
  validates :name, presence: true
end
