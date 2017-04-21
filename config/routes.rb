Rails.application.routes.draw do
  #root to: 'products#index'
  get  'products', to:  'products#index'

  # resources :products

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :merchants, only: [:show, :index]
  #
  # get 'login', to: 'merchants#new'
  #
  # post 'login', to: "merchants#create"
  #
  # delete 'logout', to: "merchants#destroy"



  # resources :merchants do
  #    resources :products, only: [:show, :new, :create, :index]
  #  end
  #
  #  resources :products


end
