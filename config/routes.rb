# frozen_string_literal: true

Rails.application.routes.draw do
  resources :categories

  devise_for :admins, controllers: {
    registrations: "admins/registrations",
    passwords: "admins/passwords"
  }

  authenticated :admin do
    # root to: 'dashboard#index', as: :authenticated_root
    root "categories#index"
  end

  unauthenticated do
    as :admin do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end
end
