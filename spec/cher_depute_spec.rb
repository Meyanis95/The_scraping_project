require_relative '../lib/cher_depute.rb'

describe "the get_final method" do
    it "should return an array of ashes with mail and names of each depute" do
      expect(get_final).not_to eq(nil)
    end
end