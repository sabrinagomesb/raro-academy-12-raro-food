# frozen_string_literal: true

class City < ApplicationRecord
  belongs_to :state, inverse_of: :cities

  validates :name, presence: true, length: { maximum: 255 }

  scope :from_state_by_acronym, ->(state_acronym) { joins(:state).where(states: { acronym: state_acronym }) }
end
