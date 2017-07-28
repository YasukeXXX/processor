Rails.application.routes.draw do
  root   'home#index'
  get    '/signup', to: 'users#new'
  post   '/signup', to: 'users#create'
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users do
    resources :videos, only: [:new, :create, :show]
    resources :fragments
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :procedures,          only: [:new, :create, :edit, :update]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
