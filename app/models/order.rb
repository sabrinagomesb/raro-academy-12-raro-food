# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :delivery_address, class_name: 'Address'

  has_many :items, class_name: 'OrderItem', dependent: :destroy
  has_many :dishes, through: :items

  has_one :city, through: :delivery_address

  enum :status, {
    started: 1,
    request: 2,
    preparing: 3,
    sent: 4,
    delivered: 5,
    finished: 6,
    canceled: 7
  }, scopes: true, default: :started

  validates :status, presence: { in: %i[started request preparing sent delivered finished canceled] }

  accepts_nested_attributes_for :delivery_address, :items, allow_destroy: true

  scope :started_between, ->(start_date, end_date) { started.where('created_at BETWEEN ? AND ?', start_date, end_date) }

  def update_total_price
    total = items.sum('amount * unit_price').to_f
    update(total_price: total)
  end
end
