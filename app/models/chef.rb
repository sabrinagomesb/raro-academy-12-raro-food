class Chef < ApplicationRecord
  belongs_to :user
  belongs_to :address
  belongs_to :approver, class_name: 'Administrator', foreign_key: 'approver_id'
end
