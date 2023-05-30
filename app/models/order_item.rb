# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :dish

  validates :amount, numericality: { only_integer: true, minimum: 1 }
  validates :unit_price, numericality: { greater_than: 0 }
  validate :can_add_item?, on: :create

  before_validation :set_unit_price
  after_destroy :update_order_total_price
  after_save :update_order_total_price
  after_commit :send_email_to_chef

  delegate :active?, :unit_price, to: :dish, prefix: true

  scope :order_items_by_dishes_on_finished_orders, lambda { |dish_id|
    joins(:order, :dish).where(dishes: { id: dish_id })
                        .where(orders: { status: :finished })
  }

  def total_per_item
    amount * unit_price
  end

  private

  def send_email_to_chef
    OrderItemMailer.order_item_added(self).deliver_later
  end

  def can_add_item?
    errors.add(:dish_id, 'is not an active and available item') unless dish.can_be_sold?
  end

  def update_order_total_price
    order.update_total_price
  end

  def set_unit_price
    self.unit_price = dish.unit_price.to_f
  end
end
