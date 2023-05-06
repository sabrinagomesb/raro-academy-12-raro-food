# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    customer
    association :delivery_address, factory: :address
  end
end
