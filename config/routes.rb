Rails.application.routes.draw do
  root to: "pages#home"
  devise_for :users

  resources :gardens, except: %i[destroy] do
    resources :recommendations, only: %i[show create]
    resources :plants, only: %i[index show destroy]
  end

  resources :resources, only: %i[index show]
end
