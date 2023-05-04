# frozen_string_literal: true

class Dish < ApplicationRecord
  # default_scope { where(active: true, available: true) }

  belongs_to :chef
  has_and_belongs_to_many :categories

  has_many :items, class_name: 'OrderItem', dependent: :destroy

  validates :name, :description, :unit_price, presence: true
  validates :available, :active, inclusion: [true, false]
  validates :unit_price, numericality: { greater_than: 0 }

  scope :costs_more_than, ->(amount) { where('unit_price > ?', amount) }
  scope :active, -> { where(active: true) }
  scope :available, -> { where(available: true) }
  scope :sold, -> { joins(items: :order).where(orders: { status: :finished }) }

  def can_be_sold?
    active? && available?
  end
end
