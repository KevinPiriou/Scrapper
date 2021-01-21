require_relative '../lib/trader'

describe "make_hash method, it should return a hash with both arrays" do
  it "Wrong type" do
    expect(perform(URL)).to eq("https://coinmarketcap.com/all/views/all/")
  end
end