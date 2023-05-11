# frozen_string_literal: true

class Card < ApplicationRecord
  belongs_to :customer

  has_many :orders, through: :customer
  has_many :payments, dependent: :destroy

  enum :card_type, %i[credit debit], scopes: true

  validates :number, :name, :security_code, :expiration_date, presence: true
  validates :card_type, presence: { in: %i[credit debit] }
end
