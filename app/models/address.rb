# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :city
  belongs_to :addressable, polymorphic: true, optional: true

  has_one :chef, inverse_of: :address, dependent: :destroy
  has_one :state, through: :city

  validates :zip_code, :public_place, :number, :neighborhood, presence: true
  validates :zip_code, length: { is: 8 }
  validates :number, length: { minimum: 1, maximum: 15 }
  validates :name, :reference, :complement, length: { maximum: 255 }, allow_blank: true

  accepts_nested_attributes_for :addressable
end
