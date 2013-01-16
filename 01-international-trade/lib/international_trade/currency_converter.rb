require 'ostruct'
require 'bigdecimal'

class CurrencyConverter

  def initialize(rates = RateHash.new)
    @rates = rates
  end

  def load_conversions(data_file)
    @rates.load(data_file)
  end

  def supports?(from, to)
    has_chain?(from, to) || has_chain?(to, from)
  end

  def rates=(rates)
    @rates.rates = rates
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

  private

  def has_chain?(from, to)
    !@rates[from, to].nil?
  end

end