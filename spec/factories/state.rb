# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name { Faker::Lorem.word.capitalize }
    acronym { Faker::Lorem.characters(number: 2, min_alpha: 2, min_numeric: 0).upcase }
  end
end
