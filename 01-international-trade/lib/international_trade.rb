require 'international_trade/currency_converter'
require 'international_trade/rate_hash'
require 'international_trade/transaction_iterator'
require 'international_trade/sales_totaler'

class InternationalTrade
  
  attr_accessor :converter, :transactions

  def initialize(arguments)
    @converter = CurrencyConverter.new(arguments[:rates])
    @transactions = TransactionIterator.new(arguments[:transactions])

    @sales_totaler = SalesTotaler.new transactions: @transactions, converter: @converter
  end

  def compute_grand_total(sku, currency)    
    total = @sales_totaler.compute_grand_total sku.upcase, currency
    total.to_s('F')
  end

end