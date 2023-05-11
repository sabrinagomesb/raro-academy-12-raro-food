# frozen_string_literal: true

class AddColumnFreightPriceToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :freight_price, :decimal, precision: 8, scale: 2, null: false, default: 0, after: :total_price
  end
end
