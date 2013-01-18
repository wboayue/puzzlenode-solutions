require 'minitest/spec'
require 'minitest/autorun'

require 'international_trade/transaction_iterator'

describe TransactionIterator do
  
  describe "#initialize" do
    it "should store data_file" do
      iterator = TransactionIterator.new(sample_tranactions_data_file)

      assert_equal sample_tranactions_data_file, iterator.data_file
    end
  end

  describe "#each_transaction" do
    before do
      @iterator = TransactionIterator.new(sample_tranactions_data_file)
    end

    it "iterator over transactions" do
      results = []
      @iterator.each_transaction do |store, item, price|
        results.push([store, item, price])
      end

      assert_equal 5, results.size

      assert_transaction_equal ['Yonkers', 'DM1210', Price.new('70.00', 'USD')], results[0]
      assert_transaction_equal ['Nashua', 'DM1182', Price.new('58.58', 'AUD')], results[2]
      assert_transaction_equal ['Camden', 'DM1182', Price.new('54.64', 'USD')], results[4]
    end
  end

  def assert_transaction_equal(expected, actual)
    assert_equal expected[0], actual[0], 'expected matching store'
    assert_equal expected[1], actual[1], 'expected matching item'
    assert_equal expected[2], actual[2], 'expected matching price'
  end

  def sample_tranactions_data_file
    File.join(File.dirname(__FILE__), 'data/sample_trans.csv')    
  end

end
