Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  post 'shop/index'
  post 'home/mailchimp', to:'home#mailchimp', as: 'mailchimp'
  post 'home/unsubscribe', to:'home#unsubscribe', as: 'unsubscribe'
  root 'shop#index'
  get 'shop/e404'
  get 'shop/shopee'
  get 'shop/blog'
  get 'users/sign_in'
  get 'users/sign_up'  
  get 'shop/cart'
  post 'shop/cart'
  get 'shop/checkout'
  get 'shop/checkout_product'
  get 'shop/order', to: 'shop#order',as: "shop_order"
  get 'shop/success', to: 'shop#success', as: "shop_success"
  get 'products/success', to: 'products#success', as: "checkout_success"
  get 'shop/track'
  post 'profile/update', to:'profile#update', as: 'profile_update'
  get 'shop/contact'
  post 'shop/contact_us'
  get 'shop/account'
  get 'products/wishlist'
  get 'home/index'  
  post 'shop/stripe'
  post 'shop/create'
  get 'shop/cod'
  post 'shop/track/:id', to: 'shop#track',as:'shop_tracks'
  get 'shop/product_details/:id', to: 'shop#product_details', as: 'product_details'


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  post "shop/add_to_cart/:id", to: "shop#add_to_cart", as: "add_to_cart"
  delete"products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"

  post 'products/:id/add' => "products#add_quantity", as: "add_quantity"
  post 'products/:id/minus' => "products#dec_quantity", as: "dec_quantity"

  post 'products/add_to_wishlist/:id', to: "products#add_to_wishlist", as: "add_to_wishlist"
  delete "products/remove_from_wishlist/:id", to: "products#remove_from_wishlist", as: "remove_from_wishlist"


  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end

  resources :products
  resources :shops


end
