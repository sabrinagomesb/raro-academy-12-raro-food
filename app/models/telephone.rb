# frozen_string_literal: true

class Telephone < ApplicationRecord
  belongs_to :contactable, polymorphic: true

  validates :number, presence: true, length: { is: 11 }
end
