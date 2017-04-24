Rails.application.routes.draw do

  root to: 'merchants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [:show, :index]

  delete 'logout', to: "merchants#logout"

  get "/auth/:provider/callback", to: "merchants#create"

  resources :merchants do
    resources :products, except: [:show] #only: [:show, :new, :create, :index]
  end

  resources :products do
    member do
      patch :retire
    end
  end

  resources :reviews, only: [:new, :create]

  resources :orders do
    member do
      put :cancel
      put :complete
    end
  end

  resources :order_products

  get "shopping_cart", to: 'orders#shopping_cart'

  resources :categories, only: [:index, :new, :create, :show]

end
