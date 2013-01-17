require 'nokogiri'
require 'ostruct'

class RateHash

  attr_writer :rates

  def initialize
    @rates = {}
  end

  def load(data_file)
    doc = Nokogiri::XML(File.new(data_file))
    doc.xpath('//rate').each do |rate|
      from, to, conversion = extract_conversion(rate)
      add_conversion(from, to, conversion)
    end
  end

  def add_conversion(from, to, conversion)
    rates[from] ||= {}
    rates[from][to] = BigDecimal.new(conversion, 4)
  end

  def [](from, to)
    if rates.has_key? from
      rates[from][to]
    end
  end

  def get_chain(from, to)
    conversions = rates[from]

    if conversions.has_key?(to)
      create_link(from, to)
    else
      conversions.each_key do |key|
        chain = get_chain(key, to)
        return create_link(from, key).concat(chain) unless chain.nil?
      end
      nil
    end
  end

  private 

  def create_link(from, to)
    [ OpenStruct.new(from: from, to: to, conversion: rates[from][to]) ]
  end

  def extract_conversion(rate)
    [
      rate.at_xpath('from').content.downcase.to_sym,
      rate.at_xpath('to').content.downcase.to_sym,
      BigDecimal.new(rate.at_xpath('conversion').content)
    ]
  end

  def rates
    @rates
  end
  
end