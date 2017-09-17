Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:show]
    resources :products, only: [:show]
    resources :shops, only: [:show, :index, :update]

    root to: "shops#index"
  end

  # resources :shops, only: [:show, :index] do
  #   resources :products
  # end

  devise_for :users

  root to: 'shops#index'
end
