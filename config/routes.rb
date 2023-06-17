Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :plants, only: %i[index show]
  resources :gardens, except: %i[destroy] do
    resources :recommendations, only: %i[show create]
    resources :plants
  end
  resources :resources, only: %i[index show]
  # resources :plants, only: %i[index show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
