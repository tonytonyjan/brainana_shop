Rails.application.routes.draw do
  root 'pages#index'

  resources :products, only: %i[show index]
  resources :orders, only: %i[show index new create]
  resources :transactions, only: :show
  resources :line_items, only: %i[create destroy]

  resource :cart, only: %i[show]

  namespace :allpay do
    get 'form/:order_id', action: :form, as: :form
    post :callback
  end

  namespace :admin do
    root action: :home
    resources :products, :carts, :orders, :transactions
  end
end
