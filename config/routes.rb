Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:show]
    resources :products, only: [:show]
    resources :shops, only: [:show, :index, :update]

    root to: "shops#index"
  end

  
  namespace :shop_admin do
    resources :shops, only: [:show, :edit, :update, :create, :new] do
      resources :products, only: [:new, :edit, :create, :update, :destroy] do
        root to: "products#index"
      end

      resources :categories do
        root to: "categories#index"
      end

      root to: "shops#new"
    end
  end

  resources :shops, only: [:show, :index] do
    resources :products, only: [:show, :index]
    resources :cart_products, only: [:create, :destroy, :update]
    resources :carts, only: :index
    resources :orders, only: [:new, :create, :show]

    delete '/cart_products', to: "cart_products#destroy"
  end

  devise_for :users

  root to: 'shops#index'
end
