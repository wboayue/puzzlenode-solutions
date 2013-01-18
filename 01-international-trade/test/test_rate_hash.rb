require 'minitest/spec'
require 'minitest/autorun'

require 'international_trade/rate_hash'

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
      @rates.rates = sample_rates
    end

    it "should populate rates" do
      assert_rates_are_loaded
    end
  end

  describe "#get_chain" do
    before do
      @rates.rates = sample_rates
    end

    it "should find simple chains" do
      from, to = :aud, :cad
      chain = @rates.get_chain(from, to)

      refute chain.nil?, "should find chain for #{from} -> #{to}"
      assert_equal 1, chain.size, 'expects one rate in chain'

      assert_equal from, chain[0].from, "expects conversion from #{from}"
      assert_equal to, chain[0].to, "expects conversion to #{to}"
    end

    it "should find multi-step chains" do
      from, to, intermediate = :aud, :usd, :cad
      chain = @rates.get_chain(from, to)

      refute chain.nil?, "should find chain for #{from} -> #{to}"
      assert_equal 2, chain.size, 'expected chain with two rates'

      assert_equal from, chain[0].from
      assert_equal intermediate, chain[0].to

      assert_equal intermediate, chain[1].from
      assert_equal to, chain[1].to
    end    

    it "should return nil if chain not found" do
      from, to = :aud, :jpy
      chain = @rates.get_chain(from, to)

      assert_nil chain, "should not find chain"
    end    

  end

  def sample_rates
    {
        aud: {cad: 1.0079},
        cad: {usd: 1.0090},
        usd: {cad: 0.9911}
    }
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
