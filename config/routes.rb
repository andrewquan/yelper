Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'businesses#index'
  resources :businesses, only: [:new, :create, :show]

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  resources :users, only: [:new, :create, :show]
end
