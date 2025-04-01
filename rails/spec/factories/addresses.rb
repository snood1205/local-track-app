# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street_line1 { '123 Main St' }
    city { 'Anytown' }
    country { 'Anywhere' }
    track { association(:track) }
  end
end
