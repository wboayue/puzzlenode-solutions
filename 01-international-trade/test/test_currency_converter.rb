require 'minitest/spec'
require 'minitest/autorun'

require 'international_trade/currency_converter'

describe CurrencyConverter do

  def sample_rates
    {
      aud: {cad: BigDecimal.new("1.0079")},
      cad: {usd: BigDecimal.new("1.0090")},
      usd: {cad: BigDecimal.new("0.9911")}
    }     
  end

  describe "#get_rate" do
    before do
      @converter = CurrencyConverter.new sample_rates
    end

    it "should compute simple conversions" do
      rate = @converter.get_rate(:aud, :cad)

      assert_equal :aud, rate.from
      assert_equal :cad, rate.to
      assert_in_delta 1.0079, rate.conversion, 0.00001
    end

    it "should compute chained conversions" do
      rate = @converter.get_rate(:aud, :usd)

      assert_equal :aud, rate.from
      assert_equal :usd, rate.to
      assert_in_delta 1.01697, rate.conversion, 0.00001
    end

    it "should compute simple reverse conversions" do
      rate = @converter.get_rate(:cad, :aud)

      assert_equal :cad, rate.from
      assert_equal :aud, rate.to
      assert_in_delta 0.99216, rate.conversion, 0.00001
    end

  end

  describe "#convert" do
    before do
      @converter = CurrencyConverter.new sample_rates
    end

    it "should convert amount given a source and destination currency" do
      assert_equal BigDecimal.new("1.02"), @converter.convert(BigDecimal.new("1.00"), :aud, :usd)
    end
  end

  describe "BigDecimal#round" do
    it "should perform bankers rounding as expected" do
      assert_equal BigDecimal.new("0.24"), BigDecimal.new("0.235").round(2, :banker), "0.235 -> 0.24"
      assert_equal BigDecimal.new("0.24"), BigDecimal.new("0.245").round(2, :banker), "0.245 -> 0.24"

      assert_equal BigDecimal.new("-0.24"), BigDecimal.new("-0.235").round(2, :banker), "-0.235 -> -0.24"
      assert_equal BigDecimal.new("-0.24"), BigDecimal.new("-0.245").round(2, :banker), "-0.245 -> -0.24"
    end
  end

end