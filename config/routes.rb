Rails.application.routes.draw do
  root to: "pages#home"
  resources :pages, only: %i[home show]

  devise_for :users, controllers: {
                       sessions: "users/sessions",
                       registrations: "users/registrations",
                     }

  resources :gardens, except: [:destroy] do
    resources :recommendations, only: [:show, :create]
    resources :plants, only: [:index, :show, :destroy]
  end

  resources :resources, only: %i[index show]
  resources :forums, only: %i[index]
end
