# frozen_string_literal: true

FactoryBot.define do
  factory :track do
    name { 'Sample' }
    length { Rational(4, 10) }
    length_unit { 'mi' }
    material { 'Red Clay' }
  end
end
