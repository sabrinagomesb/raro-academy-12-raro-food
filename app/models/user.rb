# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, :email, :cpf, :password, presence: true
  validates :cpf, length: { is: 11 }
  validates :cpf, uniqueness: { scope: :email }
  validates :password, length: { in: 6..20 }
end
