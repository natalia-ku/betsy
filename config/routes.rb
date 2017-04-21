Rails.application.routes.draw do
  #root to: 'products#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :merchants, only: [:show, :index]
  resources :categories, only: [:index, :new, :create, :show]

  # get 'login', to: 'merchants#new'
  #
  # post 'login', to: "merchants#create"
  #
  # delete 'logout', to: "merchants#destroy"
end
