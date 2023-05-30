# frozen_string_literal: true

class OrderItemMailer < ApplicationMailer
  default from: email_address_with_name('noreply@rarofood.com', 'RaroFood')

  def order_item_added(order_item)
    @order_item = order_item
    @dish = @order_item.dish
    chef_email = @dish.chef.user.email

    mail(to: chef_email, subject: 'Prato adicionado a um pedido')
  end
end
