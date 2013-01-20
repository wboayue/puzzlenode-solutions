require 'ostruct'
require 'bigdecimal'

class CurrencyConverter

  def initialize(rates = RateHash.new)
    @rates = rates
  end

  def get_rate(from, to)
    chain = rates.get_chain(from, to)
    
    if chain.nil?
      chain = rates.get_chain(to, from)
      invert(reduce_chain(chain)) unless chain.nil?
    else
      reduce_chain(chain)
    end
  end

  def self.load_conversions(data_file)
    instance.load_conversions(data_file)
  end

  def load_conversions(data_file)
    @rates.load(data_file)
  end

  def self.rate_hash=(rates)
    instance.rate_hash=(rates)
  end

  def rate_hash=(rates)
    @rates = rates
  end

  def self.rates=(rates)
    instance.rates=(rates)
  end

  def rates=(rates)
    @rates.rates = rates
  end

  def self.convert(amount, from, to)
    instance.convert(amount, from, to)
  end

  def convert(amount, from, to)
    rate = get_rate(from, to)
    raise "Unsupported conversion" if rate.nil?
    CurrencyConverter.round(amount * rate.conversion)
  end

  def self.round(amount)
    amount.round(2, :banker)
  end

  def self.instance
    @@instance ||= CurrencyConverter.new
  end

  private

  def reduce_chain(chain)
    chain.reduce do |result, link|
      OpenStruct.new(from: result.from, to: link.to, conversion: result.conversion * link.conversion)
    end
  end

  def invert(rate)
    OpenStruct.new(from: rate.to, to: rate.from, conversion: BigDecimal.new("1.0") / rate.conversion)
  end

  def rates
    @rates
  end

  def has_chain?(from, to)
    !@rates[from, to].nil?
  end

end