# app/models/wallet.rb
class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true  # Ini memungkinkan Wallet digunakan oleh User, Team, dan Stock
  has_many :transactions, dependent: :destroy

  # Menghitung saldo berdasarkan transaksi
  def balance
    transactions.sum(:amount)
  end
end
