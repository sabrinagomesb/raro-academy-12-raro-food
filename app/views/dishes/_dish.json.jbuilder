# frozen_string_literal: true

json.extract! dish, :id, :created_at, :updated_at
json.url dish_url(dish, format: :json)
