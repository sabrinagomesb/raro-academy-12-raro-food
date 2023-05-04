# frozen_string_literal: true

class Customer < ApplicationRecord
  belongs_to :user, dependent: :destroy

  has_many :orders, dependent: :destroy, inverse_of: :customer
  has_many :requested_items, through: :orders, class_name: 'OrderItem', source: :items
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :telephones, as: :contactable, dependent: :destroy

  validates :birthday, presence: true

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :addresses, :telephones, allow_destroy: true

  scope :with_orders, -> { joins(:orders).uniq }
end
