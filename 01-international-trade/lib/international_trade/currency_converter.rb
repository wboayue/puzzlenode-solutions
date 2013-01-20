require 'ostruct'
require 'bigdecimal'

class CurrencyConverter

  def initialize(rates)
    @rates = rates.instance_of?(RateHash) ? rates : RateHash.new(rates)
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

  def convert(amount, from, to)
    rate = get_rate(from, to)
    raise "Unsupported conversion" if rate.nil?
    (amount * rate.conversion).round(2, :banker)
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