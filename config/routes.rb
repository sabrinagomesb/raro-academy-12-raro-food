# frozen_string_literal: true

Rails.application.routes.draw do
  resources :dishes
  resources :categories, :dishes

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
