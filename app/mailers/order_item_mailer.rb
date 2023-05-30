# frozen_string_literal: true

class OrderItemMailer < ApplicationMailer
  include ApplicationHelper
  include ActionView::Helpers::NumberHelper

  default from: email_address_with_name('noreply@rarofood.com', 'RaroFood')

  def order_item_added(order_item)
    @order_item = order_item
    @dish = @order_item.dish
    @dish_price = usa_currancy(@order_item.dish.unit_price)
    @customer = @order_item.order.customer
    chef_email = @dish.chef.user.email

    mail(to: chef_email, subject: 'New dish order')
  end
end
