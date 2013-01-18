require 'minitest/spec'
require 'minitest/autorun'

require 'international_trade/sales_totaler'

describe SalesTotaler do

  it "should be configured with a rates file" do
    rates_file = 'rates.xml'
    totaler = SalesTotaler.new(rates_file: rates_file)
    assert_equal rates_file, totaler.rates_file
  end

  it "should be configured with a transactions file" do
    transactions_file = 'transactions.csv'
    totaler = SalesTotaler.new(transactions_file: transactions_file)
    assert_equal transactions_file, totaler.transactions_file
  end

end