Rails.application.routes.draw do
  root to: "pages#home"
  resources :pages, only: %i[home show]

  devise_for :users

  resources :gardens do
    member do
      post 'add_to_garden', to: 'gardens#add_to_garden', as: 'add_to_garden'
      delete 'remove_from_garden', to: 'gardens#remove_from_garden'
    end
    resources :recommendations, only: %i[index create show]
    resources :plants, only: %i[index show destroy]
  end

  resources :resources, only: %i[index show]
  # resources :chat, only: %i[index show]
  get 'chat/index'
  post 'chat', to: 'chat#chat'
  resources :forums, only: %i[index show] do
    resources :messages, only: :create
  end
end
