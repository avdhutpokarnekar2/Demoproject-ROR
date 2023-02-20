Rails.application.routes.draw do
  root 'home#show'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  
  resources :coupons

  resources :blogs

  resources :contacts

  resources :checkout

  resources :profile do
    collection do
      post 'mailchimp'
    end
  end

  resources :wishlist

  resources :categories

   resources :carts do
    member do
      post 'add' => "carts#add_quantity", as: "add_quantity"
      post 'minus' => "carts#dec_quantity", as: "dec_quantity"
    end
  end

  resources :addresses

  resources :orders do
    collection do
      post 'track'
    end
  end

  resources :home 
  
  resources :payment do
    collection do
      post 'stripe_payment'
      get 'stripe_paymet_success'
      get 'cod'
    end
  end

  resources :products
  
  resources :shop

end
 