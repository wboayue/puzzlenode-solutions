require 'ostruct'
require 'bigdecimal'

class CurrencyConverter

  def initialize(rates = RateHash.new)
    @rates = rates
  end

  def get_rate(from, to)
     OpenStruct.new
  end

  def get_rate_chain(from, to)
    conversion = @rates[from, to]
    
    if conversion.nil?
      conversion = BigDecimal.new("1.0") / @rates[to, from] if @rates[to, from] 
    end

    [].tap do |chain|
      chain << OpenStruct.new(from: from, to: to, conversion: conversion) unless conversion.nil?
    end
  end

  def load_conversions(data_file)
    @rates.load(data_file)
  end

  def rates=(rates)
    @rates.rates = rates
  end

  private

  def has_chain?(from, to)
    !@rates[from, to].nil?
  end

end