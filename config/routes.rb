Rails.application.routes.draw do
  root to: "pages#home"
  resources :pages, only: %i[home show]

  devise_for :users

  resources :gardens do
    member do
      post "add_plant" # Route for adding a plant to a garden
      delete "remove_plant_from_garden" # Route for removing a plant from a garden
    end
    resources :recommendations, only: %i[index create show]
    resources :plants, only: %i[index show destroy]
  end

  resources :resources, only: %i[index show]
  # resources :chat, only: %i[index show]
  get "chat/index"
  post "chat", to: "chat#chat"
  resources :forums, only: %i[index show] do
    resources :messages, only: :create
  end
end
