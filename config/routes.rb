# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories, :dishes, :customers

  resources :orders, params: :order_id do
    resources :order_items, only: [:show, :edit, :new, :create, :update, :destroy], as: "items"
  end

  # Rota para os endereços do cliente
  get "/customers/:customer_id/addresses", to: "customers#addresses", as: "customer_addresses"

  # Rotas adicionais específicas para orders
  # scope "orders", as: "orders" do
  #   get "/", to: "orders#index"
  #   post "/", to: "orders#create"
  #   get "/new", to: "orders#new"
  #   get "/:id/edit", to: "orders#edit"
  #   get "/:id", to: "orders#show"
  #   patch "/:id", to: "orders#update"
  #   put "/:id", to: "orders#update"
  #   delete "/:id", to: "orders#destroy"
  # end

  # resources :categories, :dishes, :orders, :customers

  # resources :customers do
  #   get "addresses", on: :member
  # end

  # resources :orders, params: :order_id do
  #   resources :order_items, only: %i[show new create update destroy]
  # end

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
