# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories, :dishes, :customers, :chefs

  resources :orders do
    resources :order_items, as: "items"
  end

  # Rota para os endereços do cliente
  get "/customers/:customer_id/addresses", to: "customers#addresses", as: "customer_addresses"

  devise_for :admins, controllers: {
                        registrations: "admins/registrations",
                        passwords: "admins/passwords",
                      }

  authenticated :admin do
    root "orders#index"
  end

  unauthenticated do
    as :admin do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
end
