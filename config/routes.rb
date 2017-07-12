Rails.application.routes.draw do
  root 'home#index'
  get 'users/new'
  get 'users/edit'
  get 'users/show'
  # resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
