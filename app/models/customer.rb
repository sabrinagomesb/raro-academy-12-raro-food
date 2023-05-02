# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :user

  has_many :orders, dependent: :destroy, inverse_of: :customer
  has_many :requested_items, through: :orders, class_name: 'OrderItem', source: :items
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :telephones, as: :contactable, dependent: :destroy
end
