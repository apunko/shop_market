Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:show]
    resources :products, only: [:show]
    resources :shops, only: [:show, :index, :update]

    root to: "shops#index"
  end

  
  namespace :shop_admin do
    resources :shops, only: [:show, :edit, :update] do
      resources :products, only: [:new, :edit, :create, :update, :destroy] do
        root to: "products#index"
      end

      root to: "products#index"
    end
  end

  resources :shops, only: [:show, :index] do
    resources :products, only: [:show, :index]
  end

  devise_for :users

  root to: 'shops#index'
end
