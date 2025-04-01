# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street_line1 { '123 Main St' }
    street_line2 { 'Apt A' }
    city { 'Anytown' }
    region { 'New Any' }
    postal_code { 'ANY123' }
    country { 'Anywhere' }
    track { association(:track) }
  end
end
