# app/controllers/wallets_controller.rb
class WalletsController < ApplicationController
  #before_action :authenticate_user

  def create
    Rails.logger.info("Current user: #{@current_user.inspect}")  # Tambahkan log user yang login
    wallet = Wallet.new(wallet_params)
    wallet.walletable = @current_user

    if wallet.save
      Rails.logger.info("Wallet created: #{wallet.inspect}")  # Log jika wallet berhasil dibuat
      render json: { status: 'success', wallet: wallet }, status: :created
    else
      Rails.logger.error("Error creating wallet: #{wallet.errors.full_messages}")  # Log error
      render json: { status: 'error', message: wallet.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  def show_balance
    wallet = Wallet.find(params[:id])
    render json: { balance: wallet.balance }
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Wallet not found' }, status: :not_found
  end

  private

  def wallet_params
    params.require(:wallet).permit(:balance)
  end
end
