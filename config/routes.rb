Rails.application.routes.draw do
  root to: 'merchants#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants, only: [:show, :index]

  delete 'logout', to: "merchants#logout"

  get "/auth/:provider/callback", to: "merchants#create"

end
