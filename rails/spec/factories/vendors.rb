# frozen_string_literal: true

FactoryBot.define do
  factory :vendor do
    name { 'Sample vendor' }
    slug { 'sample-vendor' }
    category { 'Food and drink' }
    track { association(:track) }
  end
end
