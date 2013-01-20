require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/mock'

require_relative 'test_helper'

require 'international_trade/sales_totaler'

describe SalesTotaler do

  include TestHelper

  describe "#initialize" do
    it "should configure converter" do
      converter = Object.new
      totaler = SalesTotaler.new(converter: converter)
      assert_equal converter, totaler.converter
    end

    it "should configure transactions file" do
      transactions = Object.new
      totaler = SalesTotaler.new(transactions: transactions)
      assert_equal transactions, totaler.transactions
    end
  end

  describe "#compute_grand_total" do
    before do
      class TransactionIteratorDouble
        include MiniTest::Assertions

        def each_transaction(filter = {})
          assert_equal 'DM1182', filter[:sku], 'expected filter by DM1182'

          yield OpenStruct.new store: 'Yonkers', sku: 'DM1182', price: Price.new('19.68', :aud)
          yield OpenStruct.new store: 'Nashua', sku: 'DM1182', price: Price.new('58.58', :aud)
          yield OpenStruct.new store: 'Camden', sku: 'DM1182', price: Price.new('54.64', :usd)
        end
      end

      @transactions = TransactionIteratorDouble.new
      @converter = CurrencyConverter.new sample_rates

      @totaler = SalesTotaler.new(transactions: @transactions, converter: @converter)
    end

    it "should compute transaction totals given sku" do
      grand_total = @totaler.compute_grand_total('DM1182', :usd)

      assert_equal BigDecimal.new('134.22'), grand_total
    end
  end

end