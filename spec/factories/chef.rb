# frozen_string_literal: true

FactoryBot.define do
  factory :chef do
    user
    association :approver, factory: :administrator
    address
  end
end
