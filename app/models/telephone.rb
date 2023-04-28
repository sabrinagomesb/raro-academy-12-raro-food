class Telephone < ApplicationRecord
  belongs_to :contactable, polymorphic: true
end
