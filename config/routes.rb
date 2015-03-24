class SignedIn
  def matches?(request)
    request.session['user_id'].present?
  end
end

Rails.application.routes.draw do
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  constraints(SignedIn.new) do
    root "dashboards#show", as: :dashboard
  end

  root "users#new"
end
