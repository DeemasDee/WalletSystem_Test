# app/models/stock.rb
class Stock < ApplicationRecord
  has_one :wallet, as: :walletable, dependent: :destroy
end
