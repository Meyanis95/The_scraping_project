require_relative '../lib/dark_trader.rb'

describe "the get_cryptos(url) method" do
    it "should return an array of crypto's name and price" do
      url = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
      expect(get_crypto_name(url)).not_to eq(nil)
    end
end
