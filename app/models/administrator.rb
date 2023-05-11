# frozen_string_literal: true

class Administrator < ApplicationRecord
  belongs_to :user, dependent: :destroy

  has_many :registered_coupons, class_name: 'Coupon', dependent: :destroy

  accepts_nested_attributes_for :user
end
