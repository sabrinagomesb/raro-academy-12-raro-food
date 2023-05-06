# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    name { Faker::Lorem.word.capitalize }
    public_place { Faker::Address.street_name }
    zip_code { Faker::Number.number(digits: 8) }
    reference { Faker::Lorem.word }
    complement { Faker::Address.secondary_address }
    number { Faker::Address.building_number }
    neighborhood { Faker::Address.community }
    city
  end
end
