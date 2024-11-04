# app/controllers/stocks_controller.rb
class StocksController < ApplicationController
  def show_price
    stock_symbol = params[:symbol]
    price_data = LatestStockPrice.price(stock_symbol)

    if price_data && price_data['price']
      render json: { status: 'ok', data: price_data }
    else
      render json: { status: 'error', message: 'Harga saham tidak tersedia' }, status: :not_found
    end
  end
end
