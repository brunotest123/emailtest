Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :guests, only: :create
    resources :shifts, only: [] do
      resources :reservations, only: [:create, :update]
    end
    resources :restaurants, only: [] do
      resources :reservations, only: [:index]
    end
  end
end
