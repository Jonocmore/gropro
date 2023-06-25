Rails.application.routes.draw do
  root to: "pages#home"
  resources :pages, only: %i[home show]

  devise_for :users

  resources :gardens, except: [:destroy] do
    resources :recommendations, only: %i[index create show]
    resources :plants, only: %i[index show destroy]
  end

  resources :resources, only: %i[index show]
  resources :forums, only: %i[index show]
end
