# frozen_string_literal: true

module Dishes
  class UpdatePriceJob < ApplicationJob
    queue_as :dishes

    def perform(dish_id, new_unit_price)
      @dish = Dish.find(dish_id)
      return if @dish.blank?

      # get the orders that have the dish
      started_orders = Order.joins(:items).where(status: :started, items: { dish_id: })
      started_orders.each do |order|
        order.items.each do |item|
          if item.dish_id == dish_id
            item.unit_price = new_unit_price
            item.save!
          end
        end
      end
    end
  end
end
