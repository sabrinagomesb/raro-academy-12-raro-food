class Address < ApplicationRecord
  belongs_to :city
  belongs_to :addressable, polymorphic: true, optional: true

  has_one :chef, inverse_of: :address
  has_one :state, through: :city
end
