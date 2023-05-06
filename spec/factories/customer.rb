# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    user
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
