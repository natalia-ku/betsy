Rails.application.routes.draw do
  root "products#top_products"
  #root to: 'merchants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [:show, :index]  ``

  delete 'logout', to: "merchants#logout"

  get "/auth/:provider/callback", to: "merchants#create" , as: "auth_callback"

  resources :merchants do
    resources :products, except: [:show] #only: [:show, :new, :create, :index]
  end

  get "merchants/:id/orders/:order_id", to: "merchants#show_merchants_order", as: "merchant_order_view"

  resources :products do
    member do
      patch :retire
    end
  end

 patch 'order_products/:id', to: 'order_products#ship', as: 'ship_order_product'


resources :reviews, only: [:new, :create]

  resources :orders do
    member do
      put :cancel
      #get :complete
    end
  end

  resources :order_products

  get "shopping_cart", to: 'orders#shopping_cart'

  resources :categories, only: [:index, :new, :create, :show]

end
