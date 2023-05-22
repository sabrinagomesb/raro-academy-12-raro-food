# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories, :dishes, :orders, :customers

  resources :customers do
    get "addresses", on: :member
  end

  resources :orders, params: :order_id do
    resources :order_items, only: %i[show new create update destroy]
  end

  devise_for :admins, controllers: {
                        registrations: "admins/registrations",
                        passwords: "admins/passwords",
                      }

  authenticated :admin do
    root "categories#index"
  end

  unauthenticated do
    as :admin do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
end
