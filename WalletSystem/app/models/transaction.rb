# app/models/transaction.rb
class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: 'Wallet', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', optional: true

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :sufficient_balance, if: :debit?

  def debit?
    type == 'DebitTransaction'
  end

  def credit?
    type == 'CreditTransaction'
  end

  private

  def sufficient_balance
    errors.add(:base, 'Saldo tidak mencukupi') if source_wallet&.balance.to_f < amount
  end
end
