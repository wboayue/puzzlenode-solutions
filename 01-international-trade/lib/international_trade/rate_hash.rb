require 'nokogiri'

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
    rates[from][to] = conversion
  end

  def [](from, to)
    if rates.has_key? from
      rates[from][to]
    end
  end

  private 

  def extract_conversion(rate)
    [
      rate.at_xpath('from').content.downcase.to_sym,
      rate.at_xpath('to').content.downcase.to_sym,
      rate.at_xpath('conversion').content.to_f
    ]
  end

  def rates
    @rates
  end
  
end