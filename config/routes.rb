Rails.application.routes.draw do
  devise_for :users
  get 'home/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # root "users#sign_up"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
