Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  
  resources :coupons

  resources :contacts

  resources :checkout

  resources :profile

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
  post 'orders/track'
  
  get 'payment/create_payment_order'
  get 'payment/cod'
  post 'payment/stripe_payment'
  get 'payment/stripe_paymet_success'

  get 'users/sign_in'
  get 'users/sign_up'
 
  post 'carts/:id/add' => "carts#add_quantity", as: "add_quantity"
  post 'carts/:id/minus' => "carts#dec_quantity", as: "dec_quantity"

  resources :products
  resources :shop

end
 