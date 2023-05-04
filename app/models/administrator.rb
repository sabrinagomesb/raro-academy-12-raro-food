# frozen_string_literal: true

class Administrator < ApplicationRecord
  belongs_to :user, dependent: :destroy

  accepts_nested_attributes_for :user
end
