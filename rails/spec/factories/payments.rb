# frozen_string_literal: true

FactoryBot.define do
  factory :payment do
    transaction_code { 'abc123' }
    menu_item { associations(:menu_item) }
    vendor { associations(:vendor) }
    total_in_cents { 100 }
  end
end
