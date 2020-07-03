Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: 'users/registrations'

  }
  
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "products#index"
  resources :products, only: [:index, :new, :show] do
    collection do
      get 'purchase_details_confirmation'
    end
  end
  resources :users, only: [:show, :destroy]
  resources :credit_cards, only: [:new, :create, :show, :destroy] do
  end
  resources :products do
    # 他の記述は省略
    resource :purchases do
      member do
        get  "buy"
        post "pay"
      end
    end
  end
end
