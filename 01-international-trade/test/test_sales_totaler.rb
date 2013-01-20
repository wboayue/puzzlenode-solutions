require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/mock'

require 'international_trade/sales_totaler'

describe SalesTotaler do

  describe "#initialize" do
    it "should configured rates file" do
      rates_file = 'rates.xml'
      totaler = SalesTotaler.new(rates_file: rates_file)
      assert_equal rates_file, totaler.rates_file
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

      CurrencyConverter.rate_hash = RateHash.new
      CurrencyConverter.rates = {
        aud: {cad: BigDecimal.new("1.0079")},
        cad: {usd: BigDecimal.new("1.0090")},
        usd: {cad: BigDecimal.new("0.9911")}
      }     

      @totaler = SalesTotaler.new(transactions: @transactions)
    end

    it "should compute transaction totals given sku" do
      grand_total = @totaler.compute_grand_total('DM1182', :usd)

      assert_equal Price.new('134.22', :usd), grand_total
    end
  end

end