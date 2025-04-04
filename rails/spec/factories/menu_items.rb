# frozen_string_literal: true

FactoryBot.define do
  factory :menu_item do
    name { 'Corn on the cob' }
    price_in_cents { 100 }
    heading { 'Food' }
    sequence(:slug) { |n| "corn-on-the-cob#{n}" }
    description { 'Fresh cooked corn on the cob with butter' }
    vendor { association(:vendor) }

    trait :pizza do
      name { 'Pizza' }
      price_in_cents { 375 }
      heading { 'Food' }
      sequence(:slug) { |n| "pizza#{n}" }
      description { 'Delicious cheese pizza' }
    end

    trait :popcorn do
      name { 'Popcorn' }
      price_in_cents { 500 }
      heading { 'Snacks' }
      sequence(:slug) { |n| "popcorn#{n}" }
      description { 'Hot fresh popcorn' }
    end

    trait :soda do
      name { 'Soda' }
      price_in_cents { 200 }
      heading { 'Beverages' }
      sequence(:slug) { |n| "soda#{n}" }
      description { 'Refreshing soda' }
    end

    trait :water do
      name { 'Water' }
      price_in_cents { 100 }
      heading { 'Beverages' }
      sequence(:slug) { |n| "water#{n}" }
      description { 'Ice cold water' }
    end

    trait :sunscreen do
      name { 'Sunscreen' }
      price_in_cents { 1500 }
      heading { 'Accessories' }
      sequence(:slug) { |n| "sunscreen#{n}" }
      description { 'SPF 50 sunscreen' }
    end
  end
end
