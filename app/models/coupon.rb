# frozen_string_literal: true

class Coupon < ApplicationRecord
  belongs_to :creator, class_name: 'Administrator'

  has_many :orders, dependent: :destroy

  validates :code, :name, :description, :total_discount, :start_date, :end_date, presence: true
  validates :total_discount, numericality: { greater_than: 0 }
end
