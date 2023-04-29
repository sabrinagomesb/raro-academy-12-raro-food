class City < ApplicationRecord
  belongs_to :state, inverse_of: :cities, dependent: :destroy
end
