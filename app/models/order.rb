class Order < ApplicationRecord
  belongs_to :customer, dependent: :destroy
  belongs_to :delivery_address, class_name: 'Address', foreign_key: 'delivery_address_id'

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
end
