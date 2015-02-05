Rails.application.routes.draw do
  resources :products, only: %i[show index]
  resources :orders, only: %i[show index] do
    resources :transactions, only: %i[index]
  end
  resource :cart, only: %i[show]

  namespace :admin do
    resources :products, :carts, :orders, :transactions
  end
end
