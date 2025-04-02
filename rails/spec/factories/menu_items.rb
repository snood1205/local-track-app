# frozen_string_literal: true

FactoryBot.define do
  factory :menu_item do
    name { 'Corn on the cob' }
    price_in_cents { 100 }
    heading { 'Food' }
    slug { 'corn-on-the-cob' }
    description { 'Fresh cooked corn on the cob with butter' }
    vendor { association(:vendor) }

    trait :pizza do
      name { 'Pizza' }
      price_in_cents { 375 }
      heading { 'Food' }
      slug { 'pizza' }
      description { 'Delicious cheese pizza' }
    end

    trait :popcorn do
      name { 'Popcorn' }
      price_in_cents { 500 }
      heading { 'Snacks' }
      slug { 'popcorn' }
      description { 'Hot fresh popcorn' }
    end

    trait :soda do
      name { 'Soda' }
      price_in_cents { 200 }
      heading { 'Beverages' }
      slug { 'soda' }
      description { 'Refreshing soda' }
    end

    trait :water do
      name { 'Water' }
      price_in_cents { 100 }
      heading { 'Beverages' }
      slug { 'water' }
      description { 'Ice cold water' }
    end

    trait :sunscreen do
      name { 'Sunscreen' }
      price_in_cents { 1500 }
      heading { 'Accessories' }
      slug { 'sunscreen' }
      description { 'SPF 50 sunscreen' }
    end
  end
end
