Rails.application.routes.draw do
  get 'user_controller/new'

  get 'user_controller/create'

  get 'user_controller/destroy'

  get 'user_controller/update'

  get 'user_controller/edit'

  get 'user_controller/show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
