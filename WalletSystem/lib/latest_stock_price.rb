# lib/latest_stock_price.rb
require 'net/http'
require 'json'
require 'uri'

module LatestStockPrice
  BASE_URL = 'https://latest-stock-price.p.rapidapi.com'
  API_KEY = 'bc8d94542fmsha458ea199d30accp187448jsnfa56a4d132dd' # Ganti dengan API Key Anda jika berbeda

  # Mengambil harga untuk satu simbol saham
  def self.price(stock_symbol)
    url = URI("#{BASE_URL}/price?symbol=#{stock_symbol}")
    response = make_request(url)
    parse_response(response)
  end

  # Mengambil harga untuk daftar simbol saham
  def self.prices(stock_symbols)
    symbols = stock_symbols.join(',')
    url = URI("#{BASE_URL}/prices?symbols=#{symbols}")
    response = make_request(url)
    parse_response(response)
  end

  # Mengambil harga untuk semua simbol saham
  def self.price_all
    url = URI("#{BASE_URL}/price_all")
    response = make_request(url)
    parse_response(response)
  end

  private

  # Method untuk membuat permintaan HTTP ke API
  def self.make_request(url)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = API_KEY
    request["x-rapidapi-host"] = 'latest-stock-price.p.rapidapi.com'

    response = http.request(request)
    puts "Response from API: #{response.body}" # Log respons untuk debugging
    response
  end

  # Method untuk mengurai respons JSON dari API
  def self.parse_response(response)
    data = JSON.parse(response.body) if response.is_a?(Net::HTTPSuccess)
    data || { error: "Data tidak ditemukan atau respons tidak valid" }
  end
end
