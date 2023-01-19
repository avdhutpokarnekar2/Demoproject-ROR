Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'shop#index'
  post 'shop/index'
  get 'shop/e404'

  get 'shop/shopee'
  get 'shop/cart'
  post 'shop/cart'
  get 'shop/checkout'
  get 'shop/track'
  post 'shop/track'
  get 'shop/checkout_product'
  post 'shop/contact_us'
  post 'shop/create'
  get 'shop/account'
  get 'shop/cod'
  get 'shop/contact'
  post 'shop/stripe'
  post 'shop/track/:id', to: 'shop#track',as:'shop_tracks'
  get 'shop/order', to: 'shop#order',as: "shop_order"
  get 'shop/success', to: 'shop#success', as: "shop_success"
  get 'shop/product_details/:id', to: 'shop#product_details', as: 'product_details'
  post 'home/mailchimp', to:'home#mailchimp', as: 'mailchimp'
  post 'home/unsubscribe', to:'home#unsubscribe', as: 'unsubscribe'
  get 'home/index'  
  get 'users/sign_in'
  get 'users/sign_up'  
  get 'products/success', to: 'products#success', as: "checkout_success"
  get 'products/wishlist'
  post 'profile/update', to:'profile#update', as: 'profile_update'


  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  #add & remove product from cart
  
  post "shop/add_to_cart/:id", to: "shop#add_to_cart", as: "add_to_cart"
  delete"products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"

  #Add & minus quantity from cart
  
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

  resources :blogs do
    collection do
     get 'blog'
    end
  end

#   resources :wishlists do
#   member do
#     get 'wishlists'
#     post 'add_to_wishlist'
#     delete 'remove_from_wishlist'
#   end
# end
end
