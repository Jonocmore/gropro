Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users, controllers: {
            sessions: "users/sessions",
            registrations: "users/registrations",
          }

  resources :gardens, except: [:destroy] do
    resources :recommendations, only: [:show, :create]
    resources :plants, only: [:index, :show, :destroy]
  end

  resources :resources, only: [:index, :show]
end
