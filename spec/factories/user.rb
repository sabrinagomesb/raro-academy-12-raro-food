# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alphanumeric(number: 10) }
  end
end
