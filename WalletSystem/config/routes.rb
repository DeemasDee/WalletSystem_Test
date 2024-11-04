# config/routes.rb
Rails.application.routes.draw do
  post 'login', to: 'sessions#create'  # Endpoint login
  get 'wallets/:id/balance', to: 'wallets#show_balance'  # Endpoint saldo wallet
  resources :wallets, only: [:create]  # Endpoint untuk membuat wallet
  resources :transactions, only: [:create]  # Endpoint untuk transaksi
  resources :transactions, only: [:index, :create]
  get 'stocks/:symbol', to: 'stocks#show_price'  # Endpoint harga saham
end
