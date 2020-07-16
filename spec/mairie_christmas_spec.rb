require_relative '../lib/mairie_christmas.rb'

describe "the get_townhall_urls method" do
    it "should return an array of urls of each towns" do
      expect(get_townhall_urls).not_to eq(nil)
    end
end