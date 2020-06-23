Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "products#index"
  resources :products, only: [:index, :new] do
    collection do
      get 'purchase_details_confirmation'
    end
  end
end