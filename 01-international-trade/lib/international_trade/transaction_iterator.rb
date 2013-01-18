require 'international_trade/price'
require 'csv'

class TransactionIterator

  attr_accessor :data_file

  def initialize(data_file)
    @data_file = data_file
  end

  def each_transaction(filters = {})
    skus = extract_sku_filter(filters)
    CSV.foreach(data_file, headers: true) do |row|
      sku = row['sku']
      if skus.empty? || skus.include?(sku) 
        yield row['store'], sku, Price.new(*row['amount'].split(' '))
      end
    end
  end

  private 

  def extract_sku_filter(filters)
    skus = []
    skus.push(filters[:sku]) if filters.has_key? :sku
    skus.flatten
  end

end
