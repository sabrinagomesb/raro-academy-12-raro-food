# frozen_string_literal: true

FactoryBot.define do
  factory :dish do
    chef
    name { Faker::Alphanumeric.alpha(number: 30) }
    description { Faker::Lorem.sentence }
    available { false }
    active { false }
    unit_price { Faker::Commerce.price }

    trait :active do
      active { true }
    end

    trait :available do
      available { true }
    end
  end
end
