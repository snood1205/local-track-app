# frozen_string_literal: true

class Vendor < ApplicationRecord
  belongs_to :track
  has_many :menu_items, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 28 },
                   format: { with: /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\z/ }

  before_validation :generate_slug, on: %i[create update]

  def menu
    menu_items.each_with_object(Hash.new { |hash, key| hash[key] = [] }) do |item, by_heading|
      heading = item.heading || '*'
      by_heading[heading] << { name: item.name, description: item.description, price: item.price }
    end
  end

  private

  def generate_slug = (self.slug = name.parameterize if slug.blank?)
end
