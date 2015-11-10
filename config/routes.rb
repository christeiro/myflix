Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'
  resources :videos, only: [:show, :search] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
end
