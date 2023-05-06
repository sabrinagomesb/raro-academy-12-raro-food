# frozen_string_literal: true

FactoryBot.define do
  factory :telephone do
    number { Faker::Number.number(digits: 11) }
    association :contactable, factory: :customer
  end
end
