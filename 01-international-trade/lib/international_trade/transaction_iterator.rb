require 'international_trade/price'
require 'csv'

class TransactionIterator

  attr_accessor :data_file

  def initialize(data_file)
    @data_file = data_file
  end

  def each_transaction
    CSV.foreach(data_file, headers: true) do |row|
      yield row['store'], row['sku'], Price.new(*row['amount'].split(' '))
    end
  end

end
