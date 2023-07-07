Rails.application.routes.draw do
  root to: "pages#home"
  resources :pages, only: [:home, :show]

  devise_for :users

  resources :users, only: [] do
    member do
      get :profile
    end
  end

  resources :gardens do
    member do
      post "add_to_garden", to: "gardens#add_to_garden", as: "add_to_garden"
      delete "remove_from_garden", to: "gardens#remove_from_garden"
    end
    resources :recommendations, only: [:index, :create, :show]
    resources :plants, only: [:index, :show, :destroy]
  end

  resources :resources, only: [:index, :show]

  get "chat/index"
  post "chat", to: "chat#chat"

  resources :forums, only: [:index, :show] do
    resources :messages, only: :create
  end
end
