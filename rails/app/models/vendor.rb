# frozen_string_literal: true

class Vendor < ApplicationRecord
  belongs_to :track
  has_many :menu_items, dependent: :destroy

  validates :name, presence: true
end
