# app/controllers/transactions_controller.rb
class TransactionsController < ApplicationController
  before_action :authenticate_user

  def index
    transactions = Transaction.all
    render json: transactions
  end

  def create
    ActiveRecord::Base.transaction do
      transaction = Transaction.create!(transaction_params)
      render json: { status: 'sukses', transaction: transaction }
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { status: 'gagal', message: e.message }, status: :unprocessable_entity
  end

  private

  def transaction_params
    params.require(:transaction).permit(:amount, :source_wallet_id, :target_wallet_id)
  end
end
