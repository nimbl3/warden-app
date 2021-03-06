Rails.application.routes.draw do
  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  root to: 'static#index'
end
