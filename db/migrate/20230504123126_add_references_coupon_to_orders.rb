# frozen_string_literal: true

class AddReferencesCouponToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :coupon, foreign_key: true, null: true, after: :status
  end
end
