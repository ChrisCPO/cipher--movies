Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :dashboard, only: [:show]
  resource :session, only: [:new, :create, :destroy]

  root "users#new"
end
