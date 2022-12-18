Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'shop#index'
  get 'shop/e404'
  get 'shop/shopee'
  get 'shop/blog'
  get 'shop/contact_us'
  get 'users/sign_in'  
  get 'shop/cart'
  get 'shop/checkout'
  get 'shop/success'
  get 'shop/account'
  get 'checkout/show'
  get 'products/wishlist'
  get 'home/index'  
  post 'checkout/show'
  post 'shop/cart'
  post 'shop/create'

  # get 'shop/product_details'
  get 'shop/product_details/:id', to: 'shop#product_details', as: 'product_details'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post "shop/add_to_cart/:id", to: "shop#add_to_cart", as: "add_to_cart"
  delete"shop/remove_from_cart/:id", to: "shop#remove_from_cart", as: "remove_from_cart"

  post 'products/:id/add' => "products#add_quantity", as: "add_quantity"
  post 'products/:id/minus' => "products#dec_quantity", as: "dec_quantity"

  post 'products/add_to_wishlist/:id', to: "products#add_to_wishlist", as: "add_to_wishlist"
  delete "products/remove_from_wishlist/:id", to: "products#remove_from_wishlist", as: "remove_from_wishlist"
end
