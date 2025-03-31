# frozen_string_literal: true

class Track < ApplicationRecord
  include Validations
  validate :validate_single_row_table
  validates_presence_of :name, :length, :length_unit, :material
  validates :length, numericality: { greater_than: 0 }
  validates :length_unit, inclusion: { in: %w[mi km yd ft m] }
  has_one :address, dependent: :destroy
end
