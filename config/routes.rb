Myflix::Application.routes.draw do
  root to: 'pages#front'
  resources :videos, only: [:show, :search] do
    collection do
      get 'search', to: 'videos#search'
    end
    resource :reviews, only: [:create]
  end
  get 'ui(/:action)', controller: 'ui'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'home', to: 'videos#index'
  get 'sign_out', to: 'sessions#destroy'
  resources :users, only: [:create, :show]
  resources :categories, only: [:show]
  resources :sessions, only: [:create]
  get 'my_queue', to: 'queue_items#index'
end
