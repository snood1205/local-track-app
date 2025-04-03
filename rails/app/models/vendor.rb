# frozen_string_literal: true

class Vendor < ApplicationRecord
  include Sluggable
  belongs_to :track
  has_many :menu_items, dependent: :destroy

  def menu
    menu_items.each_with_object(Hash.new { |hash, key| hash[key] = [] }) do |item, by_heading|
      heading = item.heading || '*'
      by_heading[heading] << item.as_json(only: %i[description name slug], methods: :price)
    end
  end
end
