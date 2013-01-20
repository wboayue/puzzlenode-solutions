require 'international_trade/currency_converter'
require 'international_trade/rate_hash'
require 'international_trade/transaction_iterator'
require 'international_trade/sales_totaler'

class InternationalTrade
  
  attr_accessor :rates, :transactions

  def initialize(arguments)
    @rates = arguments[:rates]
    @transactions = arguments[:transactions]
  end

  def compute_grand_total(sku, currency)
    CurrencyConverter.load_conversions(rates)
    trans = TransactionIterator.new(transactions)
    sales_totaler = SalesTotaler.new transactions: trans
    sales_totaler.compute_grand_total sku.upcase, currency
  end

end