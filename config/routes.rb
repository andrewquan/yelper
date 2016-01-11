Myflix::Application.routes.draw do
  root to: 'businesses#index'
  
  get 'ui(/:action)', controller: 'ui'
  
  get '/home', to: 'businesses#index'
  resources :businesses, only: [:new, :create, :show] do
    collection do
      post :search, to: 'businesses#search'
    end
    resources :reviews, only: [:create]
  end

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  get '/register', to: 'users#new'
  resources :users, only: [:new, :create, :show]
end
