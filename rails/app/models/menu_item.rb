# frozen_string_literal: true

class MenuItem < ApplicationRecord
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
