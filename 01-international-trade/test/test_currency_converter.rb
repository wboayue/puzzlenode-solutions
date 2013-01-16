require 'minitest/spec'
require 'minitest/autorun'

require 'international_trade'

describe CurrencyConverter do

  before do
    @currency_converter = CurrencyConverter.new

    @currency_converter.rates = {
      aud: {cad: 1.0079},
      cad: {usd: 1.0090},
      usd: {cad: 0.9911}
    }     
  end

  describe "#supports?" do
    before do
    end

    describe "should support defined conversions" do
      defined_conversions = [[:aud, :cad], [:cad, :usd], [:usd, :cad]]

      defined_conversions.each do |from, to|
        it "should support conversion from #{from} to #{to}" do
          assert @currency_converter.supports?(from, to), "does not support conversion from #{from} to #{to}"
        end
      end
    end

    describe "should support derived conversions" do
      derived_conversions = [[:aud, :usd], [:usd, :aud], [:cad, :aud]]

      derived_conversions.each do |from, to|
        it "should support conversion from #{from} to #{to}" do
          assert @currency_converter.supports?(from, to), "does not support conversion from #{from} to #{to}"
        end
      end
    end

    describe "should not support an unkown conversion" do
      it "should not support conversion from JAP to USD" do
        refute @currency_converter.supports? :jpy, :usd
      end
    end
  end

end