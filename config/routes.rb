# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  root to: 'products#index'

  resources :merchants, only: [:show, :index]
  get 'login', to: 'merchants#new'
  post 'login', to: "merchants#create"
  delete 'logout', to: "merchants#destroy"


  resources :products, only: [:show, :index]
  
  resources :merchants do
    resources :products, except: [:show]
    # resources :products, only: [:show, :new, :create, :index]
  end


end
