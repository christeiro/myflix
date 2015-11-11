Myflix::Application.routes.draw do
  root to: 'users#index'
  get 'ui(/:action)', controller: 'ui'
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#register'

  get 'home', to: 'videos#index'
  resources :videos, only: [:show, :search] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
end
