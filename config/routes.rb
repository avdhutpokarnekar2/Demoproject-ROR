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

  resources :checkout

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
    end
  end
  
  root 'home#home'
  
  get 'orders/track'
  post 'orders/track'
  
  get 'shop/checkout_product'
  get 'shop/cod'
  post 'shop/stripe'
  get 'shop/success'

  get 'users/sign_in'
  get 'users/sign_up'
 
  post 'carts/:id/add' => "carts#add_quantity", as: "add_quantity"
  post 'carts/:id/minus' => "carts#dec_quantity", as: "dec_quantity"

  resources :products
  resources :shop
end
 