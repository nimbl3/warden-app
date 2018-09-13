Rails.application.routes.draw do
  root to: 'static#index'

  resources :sessions, only: [:new, :create, :destroy]
end
