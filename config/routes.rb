Rails.application.routes.draw do
  root 'pages#index'
  resources :products, only: %i[show index]
  resources :orders, only: %i[show new create]
  resource :cart, only: %i[show]
  resources :line_items, only: %i[create destroy] # add to/remove from cart

  namespace :allpay do
    get 'form/:slug', slug: /\w{6}/, action: :form, as: :form
    post :callback
  end

  namespace :admin do
    resources :products, :carts
    resources :orders, :transactions, only: %i[show index]
  end
end
