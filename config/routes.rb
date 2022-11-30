Rails.application.routes.draw do
  # devise_for :users,:controllers =>{ :omniauth_callbacks => "callbacks" }
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'home/index'  
  root 'shop#index'
  get "shop/e404"
  get 'shop/shopee'
  get 'shop/blog'
  get 'shop/contact_us'
  get 'users/sign_in'  
  get 'shop/cart'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"





  # root "users#sign_up"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
