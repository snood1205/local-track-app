# frozen_string_literal: true

FactoryBot.define do
  factory :vendor do
    name { 'Sample vendor' }
    sequence(:slug) { |n| "vendor-slug-#{n}" }
    category { 'Food and drink' }
    track { association(:track) }
  end
end
