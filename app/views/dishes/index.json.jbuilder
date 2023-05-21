# frozen_string_literal: true

json.array! @dishes, partial: 'dishes/dish', as: :dish
