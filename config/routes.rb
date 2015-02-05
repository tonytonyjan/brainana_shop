Rails.application.routes.draw do
  resources :products, :orders, only: %i[show index]
  resource :cart, only: %i[show]
  namespace :admin do
    resources :products, :carts
    resources :orders, :transactions, only: %i[show index]
  end
end
