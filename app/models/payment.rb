# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :card, optional: true

  has_one :customer, through: :order

  enum :payment_type, %i[pix bill credit_card debit_card], scopes: true
  enum :state, { pendent: 'pendent', paid: 'paid', canceled: 'canceled' }, scopes: true
end
