# frozen_string_literal: true

class Chef < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :approver, class_name: "Administrator"
  belongs_to :address, inverse_of: :chef

  has_one :city, through: :address
  has_one :state, through: :city

  has_many :telephones, as: :contactable, dependent: :destroy
  has_many :dishes, dependent: :destroy, inverse_of: :chef

  accepts_nested_attributes_for :user, :address
  accepts_nested_attributes_for :telephones, :dishes, allow_destroy: true
end
