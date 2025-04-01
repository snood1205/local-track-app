# frozen_string_literal: true

class Track < ApplicationRecord
  include Validations
  validate :validate_single_row_table
  validates :name, :length, :length_unit, :material, presence: true
  validates :length, numericality: { greater_than: 0 }
  validates :length_unit, inclusion: { in: %w[mi km yd ft m] }
  has_one :address, dependent: :destroy
end
