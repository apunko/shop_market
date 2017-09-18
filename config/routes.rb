Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:show]
    resources :products, only: [:show]
    resources :shops, only: [:show, :index, :update]

    root to: "shops#index"
  end

  resources :shops, only: [:show, :index] do
    namespace :shop_admin, path: :admin do
      resources :products, only: [:new, :edit, :create, :update, :destroy] do
        root to: "products#index"
      end

      root to: "products#index"
    end
    
    resources :products, only: [:show, :index]
  end

  devise_for :users

  root to: 'shops#index'
end
