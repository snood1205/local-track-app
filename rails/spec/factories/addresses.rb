# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street_line1 { '123 Main St' }
    city { 'Anytown' }
    country { 'Anywhere' }
    track { association(:track) }

    trait :full do
      street_line2 { 'Apt 1A' }
      region { 'New Any' }
      postal_code { 'ANY123' }
    end
  end
end
