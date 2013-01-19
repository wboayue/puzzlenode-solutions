class SalesTotaler

  attr_accessor :rates_file, :transactions

  def initialize(args = {})
    @rates_file = args[:rates_file]
    @transactions = args[:transactions]
  end

  def compute_grand_total(sku, currency)
    grand_total = Price.new("0", currency)

    @transactions.each_transaction(sku: sku) do |transaction|
      grand_total += transaction.price
    end

    grand_total
  end

end