Rails.application.routes.draw do
  root to: "pages#home", as: :home

  devise_for :users
  resources :users, only: [] do
    # resources :gardens, only: [:index, :show]
  end

  resources :gardens, only: [:show, :new, :create, :edit, :update] do
    resources :recommendations, only: [:index]
    resources :plants, only: [:index, :new, :create, :show, :destroy]
  end

  resources :resources, only: [:index, :show]
end
