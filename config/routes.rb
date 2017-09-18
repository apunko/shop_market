Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: [:show]
    resources :products, only: [:show]
    resources :shops, only: [:show, :index, :update]

    root to: "shops#index"
  end

  resources :shops, only: [:show, :index] do
    nested do
      scope :admin do
        resources :products, only: [:new, :edit, :create, :update, :destroy]

        root to: "products#index"
      end
    end
    
    resources :products, only: [:show, :index]
  end

  devise_for :users

  root to: 'shops#index'
end
