# frozen_string_literal: true

json.array! @chefs, partial: 'chefs/chef', as: :chef
