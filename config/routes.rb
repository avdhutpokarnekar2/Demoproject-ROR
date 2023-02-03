Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  
  resources :blogs

  resources :contacts

  resources :profile, only: [:index]
  post 'profile/update_profile'

  resources :wishlist

  resources :categories

  resources :carts

  resources :addresses

  resources :orders

  resources :home do
    collection do
     post 'mailchimp'
     post 'unsubscribe'
    end
  end

  root 'shop#index'
  get 'shop/checkout'
  get 'shop/track'
  post 'shop/track'
  get 'shop/checkout_product'
  post 'shop/create'
  get 'shop/cod'
  post 'shop/stripe'
  post 'shop/index'
  post 'shop/track/:id', to: 'shop#track',as:'shop_tracks'
  get 'shop/order', to: 'shop#order',as: "shop_order"
  get 'shop/success', to: 'shop#success', as: "shop_success"
  get 'users/sign_in'
  get 'users/sign_up'  
 
  post 'carts/:id/add' => "carts#add_quantity", as: "add_quantity"
  post 'carts/:id/minus' => "carts#dec_quantity", as: "dec_quantity"

  resources :products
  resources :shops
end
 