# frozen_string_literal: true

FactoryBot.define do
  factory :menu_item do
    name { 'Corn on the cob' }
    price_in_cents { 100 }
    heading { 'Corn' }
    description { 'Fresh cooked corn on the cob with butter' }
    vendor { association(:vendor) }
  end
end
