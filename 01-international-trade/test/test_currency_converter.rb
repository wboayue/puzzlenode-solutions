require 'minitest/spec'
require 'minitest/autorun'

require 'international_trade'

# describe CurrencyConverter do
#   before do
#     @currency_converter = CurrencyConverter.new 
#   end

#   describe "#supports?" do
#     describe "should support explicit conversions" do
#       it "should support conversion from AUD to CAD" do
#         assert @currency_converter.supports? :aud, :cad
#       end

#       it "should support conversion from CAD to USD" do
#         assert @currency_converter.supports? :cad, :usd
#       end

#       it "should support conversion from USD to CAD" do
#         assert @currency_converter.supports? :usd, :cad
#       end
#     end

#     describe "should support derived conversions" do
#       it "should support conversion from AUD to USD" do
#         assert @currency_converter.supports? :aud, :usd
#       end

#       it "should support conversion from USD to AUD" do
#         assert @currency_converter.supports? :usd, :aud
#       end

#       it "should support conversion from CAD to AUD" do
#         assert @currency_converter.supports? :cad, :aud
#       end
#     end

#     describe "should not support an unkown conversion" do
#       it "should not support conversion from JAP to USD" do
#         refute @currency_converter.supports? :jpy, :usd
#       end
#     end    
#   end

# end