# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :dish

  validates :amount, numericality: { only_integer: true, minimum: 1 }
  validates :unit_price, numericality: { greater_than: 0 }
  validate :can_add_item?, on: :create

  after_destroy :update_order_total_price
  after_save :update_order_total_price

  private

  def can_add_item?
    errors.add(:dish_id, 'is not an active and available item') unless dish.can_be_sold?
  end

  def update_order_total_price
    order.update_total_price
  end
end
