class SignedIn
  def matches?(request)
    request.session['user_id'].present?
  end
end

Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resource :search, only: [:show] do
    resources :movies, only: [:show]
  end

  constraints(SignedIn.new) do
    root "dashboards#show", as: :dashboard
  end

  root "users#new"
end
