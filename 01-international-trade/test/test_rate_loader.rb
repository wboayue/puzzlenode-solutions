require 'minitest/spec'
require 'minitest/autorun'

require 'international_trade'

describe RateHash do

  before do
    @rates = RateHash.new
  end

  describe "#load" do
    before do
      @rates.load rates_data_file
    end

    it "should load rates into hash" do
      assert_rates_are_loaded
    end
  end

  describe "#rates=" do
    before do
      @rates.rates = {
        aud: {cad: 1.0079},
        cad: {usd: 1.0090},
        usd: {cad: 0.9911}
      }
    end

    it "should populate rates" do
      assert_rates_are_loaded
    end
  end

  def rates_data_file
    File.join(File.dirname(__FILE__), 'data/sample_rates.xml')
  end

  def assert_rates_are_loaded
    refute @rates[:aud, :cad].nil?, 'no rates for aud -> cad'
    assert_in_delta @rates[:aud, :cad], 1.0079, 0.00001

    refute @rates[:cad, :usd].nil?, 'no rates for cad -> usd'
    assert_in_delta @rates[:cad, :usd], 1.0090, 0.00001
    
    refute @rates[:usd, :cad].nil?, 'no rates for usd -> cad'
    assert_in_delta @rates[:usd, :cad], 0.9911, 0.00001
  end

end
