# frozen_string_literal: true

class MenuItem < ApplicationRecord
  include Sluggable
  validates :price_in_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  belongs_to :vendor

  def price
    currency = I18n.t 'currency'
    price_str = "#{price_in_cents / 100}.#{price_in_cents % 100}"
    ActionController::Base.helpers.number_to_currency(price_str, unit: currency)
  end

  def to_h
    { name:, description:, price: }
  end
end
