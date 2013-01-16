require 'minitest/spec'
require 'minitest/autorun'

require 'international_trade'

describe CurrencyConverter do

  describe "#load_conversions" do
    before do
      @rates = MiniTest::Mock.new
      @currency_converter = CurrencyConverter.new(@rates)
    end

    it "should load rate hash" do
      data_file = "rates.xml"
      @rates.expect :load, nil, [data_file]

      @currency_converter.load_conversions(data_file)

      @rates.verify
    end
  end

  describe "#get_rates_chain" do
    before do
      @currency_converter = CurrencyConverter.new

      @currency_converter.rates = {
        aud: {cad: 1.0079},
        cad: {usd: 1.0090},
        usd: {cad: 0.9911}
      }     
    end

    it "should support defined chains" do
      rate_chain = @currency_converter.get_rate_chain(:aud, :cad)

      refute rate_chain.nil?
      assert_equal 1, rate_chain.size

      rate = rate_chain.first

      assert_equal :aud, rate.from
      assert_equal :cad, rate.to
      assert_in_delta 1.0079, rate.conversion, 0.00001
    end

    it "should derive the reverse of a defined conversion" do
      rate_chain = @currency_converter.get_rate_chain(:cad, :aud)

      refute rate_chain.nil?
      assert_equal 1, rate_chain.size

      rate = rate_chain.first

      assert_equal :cad, rate.from
      assert_equal :aud, rate.to
      assert_in_delta 0.99216, rate.conversion, 0.00001
    end

  end

end