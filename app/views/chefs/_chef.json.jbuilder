# frozen_string_literal: true

json.extract! chef, :id, :created_at, :updated_at
json.url chef_url(chef, format: :json)
