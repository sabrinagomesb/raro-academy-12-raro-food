# frozen_string_literal: true
require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  resources :categories, :dishes, :customers, :chefs
  resources :orders

  # Rota para os endereços do cliente
  get "/customers/:customer_id/addresses", to: "customers#addresses", as: "customer_addresses"

  devise_for :admins, controllers: {
                        registrations: "admins/registrations",
                        passwords: "admins/passwords",
                      }

  authenticated :admin do
    root "dishes#index"
  end

  unauthenticated do
    as :admin do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
end
