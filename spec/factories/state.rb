# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name { Faker::Alphanumeric.alpha(number: 2) }
    acronym { Faker::Lorem.characters(number: 2, min_alpha: 2, min_numeric: 0).upcase }

    trait :mg do
      acronym { 'MG' }
    end
  end
end
