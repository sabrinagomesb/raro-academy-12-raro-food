class City < ApplicationRecord
  belongs_to :state, inverse_of: :cities
end
