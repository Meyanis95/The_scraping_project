require 'rubygems'
require 'nokogiri'
require 'open-uri' 

url = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))

def get_crypto_name(url)
    crypto_names = Array.new
    url.css("td[@class = 'cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol']").each do |node|
        puts "La crypto #{node.text} est enregistrée dans la base de données"
        crypto_names.append(node.text)
    end
    return crypto_names
end

def get_crypto_price(url)
    crypto_prices = Array.new
    url.css("td[@class = 'cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price']").each do |node|
        price = node.text.gsub(/[^\d^.]/, '').to_f
        crypto_prices.append(price)
    end
    return crypto_prices 
end

def get_cryptos(url)
    crypto_names = get_crypto_name(url)
    crypto_prices = get_crypto_price(url)
    cryptos = Hash[crypto_names.zip crypto_prices]
    print cryptos
end

get_cryptos(url)
