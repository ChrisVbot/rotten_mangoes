Rails.application.routes.draw do

  get 'reviews/new'

  get 'reviews/create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  
  resources :movies do
    resources :reviews, only: [:new, :create]
  end
  
  resources :users, only: [:new, :create, :show]


  resource :session, only: [:new, :create, :destroy]
  get 'logout', to: "sessions#destroy", as: :logout
  get 'login', to: "sessions#create", as: :login




  namespace :admin do
    resources :users 
  end    

  root to: 'movies#index'

end

