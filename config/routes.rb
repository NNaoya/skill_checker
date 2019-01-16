Rails.application.routes.draw do
  root 'toppages#index'

  resources 'users'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/welcomes/index', to: 'welcomes#index'

  get '/skill_registration_update/index', to: 'skill_registration_update#index'
  post '/skill_registration_update', to: 'skill_registration_update#create'
  patch '/skill_registration_update', to: 'skill_registration_update#create'

  get 'userskills/new',to: 'userskills#new'
  post 'userskills/create', to: 'userskills#create'
  get '/userskills/update',to: 'userskills#update'

  get 'skill_reference/index',to: 'skill_reference#index'

  get 'usersearches/index',to: 'usersearches#index'
  post 'usersearches/index',to: 'usersearches#index'
  get 'usersearches/search',to: 'usersearches#search'

  get 'categories/new', to: 'categories#new'
  get 'categories/update', to: 'categories#update'
  patch 'categories/create', to: 'categories#create'

  get 'admins/index', to: 'admins#index'
  patch 'admins/update', to: 'admins#update'

end
