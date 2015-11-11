Myflix::Application.routes.draw do
  root to: 'pages#front'
  resources :videos, only: [:show, :search] do
    collection do
      get 'search', to: 'videos#search'
    end
  end  
  get 'ui(/:action)', controller: 'ui'
  get '/register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  resources :users, only: [:create]
  resources :categories, only: [:show]
end
