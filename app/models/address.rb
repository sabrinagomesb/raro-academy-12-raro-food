# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :city
  belongs_to :addressable, polymorphic: true, optional: true

  has_one :chef, inverse_of: :address, dependent: :destroy
  has_one :state, through: :city

  accepts_nested_attributes_for :addressable
end
