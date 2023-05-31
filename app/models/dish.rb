# frozen_string_literal: true

class Dish < ApplicationRecord
  # Comentado para evitar default_scope
  # default_scope { where(active: true, available: true) }
  has_one_attached :cover_image
  has_rich_text :content

  belongs_to :chef
  has_and_belongs_to_many :categories

  has_many :items, class_name: 'OrderItem', dependent: :destroy

  validates :name, :content, :unit_price, presence: true
  validates :available, :active, inclusion: [true, false]
  validates :unit_price, numericality: { greater_than: 0 }

  after_commit :enqueue_price_update_job, on: :update

  scope :costs_more_than, ->(amount) { where('unit_price > ?', amount) }
  scope :active, -> { where(active: true) }
  scope :available, -> { where(available: true) }
  scope :sold, -> { joins(items: :order).where(orders: { status: :finished }) }
  scope :sold_by_dish, ->(dish_id) { where(dishes: { id: dish_id }) }

  def can_be_sold?
    active? && available?
  end

  private

  def enqueue_price_update_job
    price = unit_price.to_f
    Dishes::UpdatePriceJob.perform_later(id, price)
    Category.create!(name: 'New test category')
  end
end
