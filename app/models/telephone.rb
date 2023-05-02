# frozen_string_literal: true

class Telephone < ApplicationRecord
  belongs_to :contactable, polymorphic: true
end
