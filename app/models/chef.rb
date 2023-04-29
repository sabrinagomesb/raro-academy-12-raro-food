class Chef < ApplicationRecord
  belongs_to :user
  belongs_to :address, inverse_of: :chef
  belongs_to :approver, class_name: 'Administrator', foreign_key: 'approver_id'

  has_many :dishes, dependent: :destroy
  has_many :telephones, as: :contactable, dependent: :destroy

  has_one :city, through: :address
  has_one :state, through: :city
end
