Rails.application.routes.draw do
  
  get 'cards/new'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "products#index"
  resources :products, only: [:index, :new]
  resources :users, only: [:show, :destroy]
  resources :cards, only: [:new]
end
