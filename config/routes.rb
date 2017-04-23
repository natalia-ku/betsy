Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do
    resources :products, only: [:show, :new, :create, :index]
  end

  resources :products

  resources :orders
  resources :order_products

  get "shopping_cart", to: 'orders#shopping_cart'
end
