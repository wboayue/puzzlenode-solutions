require 'minitest/spec'
require 'minitest/autorun'

require 'international_trade/currency_converter'

describe CurrencyConverter do

  describe "#instance" do
    it "should return same instance on multiple calls" do
      assert_equal CurrencyConverter.instance.object_id, CurrencyConverter.instance.object_id 
    end
  end

  describe "#load_conversions" do
    before do
      @rates = MiniTest::Mock.new
      CurrencyConverter.rate_hash = @rates
    end

    it "should load rate hash" do
      data_file = "rates.xml"
      @rates.expect :load, nil, [data_file]

      CurrencyConverter.load_conversions(data_file)

      @rates.verify
    end
  end

  describe "#get_rate" do
    before do
      @currency_converter = CurrencyConverter.instance

      @currency_converter.rates = {
        aud: {cad: BigDecimal.new("1.0079")},
        cad: {usd: BigDecimal.new("1.0090")},
        usd: {cad: BigDecimal.new("0.9911")}
      }     
    end

    it "should compute simple conversions" do
      rate = @currency_converter.get_rate(:aud, :cad)

      assert_equal :aud, rate.from
      assert_equal :cad, rate.to
      assert_in_delta 1.0079, rate.conversion, 0.00001
    end

    it "should compute chained conversions" do
      rate = @currency_converter.get_rate(:aud, :usd)

      assert_equal :aud, rate.from
      assert_equal :usd, rate.to
      assert_in_delta 1.01697, rate.conversion, 0.00001
    end

    it "should compute simple reverse conversions" do
      rate = @currency_converter.get_rate(:cad, :aud)

      assert_equal :cad, rate.from
      assert_equal :aud, rate.to
      assert_in_delta 0.99216, rate.conversion, 0.00001
    end

  end

  describe "#convert" do
    before do
      CurrencyConverter.rates = {
        aud: {cad: BigDecimal.new("1.0079")},
        cad: {usd: BigDecimal.new("1.0090")},
        usd: {cad: BigDecimal.new("0.9911")}
      }     
    end

    it "should convert amount given a source and destination currency" do
      assert_equal BigDecimal.new("1.02"), CurrencyConverter.convert(BigDecimal.new("1.00"), :aud, :usd)
    end
  end

  describe "#round" do
    it "should perform bankers rounding" do
      assert_equal BigDecimal.new("0.24"), CurrencyConverter.round(BigDecimal.new("0.235")), "0.235 -> 0.24"
      assert_equal BigDecimal.new("0.24"), CurrencyConverter.round(BigDecimal.new("0.245")), "0.245 -> 0.24"

      assert_equal BigDecimal.new("-0.24"), CurrencyConverter.round(BigDecimal.new("-0.235")), "-0.235 -> -0.24"
      assert_equal BigDecimal.new("-0.24"), CurrencyConverter.round(BigDecimal.new("-0.245")), "-0.245 -> -0.24"
    end
  end

end