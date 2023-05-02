# frozen_string_literal: true

class Dish < ApplicationRecord
  belongs_to :chef
  has_and_belongs_to_many :categories

  has_many :items, class_name: 'OrderItem', dependent: :destroy
end
