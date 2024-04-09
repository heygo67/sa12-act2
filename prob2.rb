require 'httparty'

def get_crypto_data(currency)
    url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=#{currency}"
    response = HTTParty.get(url)
    if response.success?
        return JSON.parse(response.body)
    else
        puts "Error: #{response.code} - #{response.message}"
        return nil
    end
end

def sort_by_market_cap(crypto_data)
    sorted_data = crypto_data.sort_by { |crypto| -crypto['market_cap'] }
    return sorted_data
end

def display_top_cryptos(crypto_data, num)
    puts "Top #{num} Cryptocurrencies by Market Capitalization:"
    crypto_data.first(num).each_with_index do |crypto, index|
        puts "#{index + 1}. #{crypto['name']} - Price: $#{crypto['current_price']} - Market Cap: $#{crypto['market_cap']}"
    end
end

currency = 'usd'
crypto_data = get_crypto_data(currency)

if crypto_data
    sorted_crypto_data = sort_by_market_cap(crypto_data)
    display_top_cryptos(sorted_crypto_data, 5)
end
