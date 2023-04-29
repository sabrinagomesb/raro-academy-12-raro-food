class State < ApplicationRecord
  has_many :cities, dependent: :destroy, inverse_of: :state
end
