class SalesTotaler

  attr_accessor :converter, :transactions

  def initialize(args = {})
    @converter = args[:converter]
    @transactions = args[:transactions]
  end

  def compute_grand_total(sku, currency)
    grand_total = BigDecimal.new("0.0")

    @transactions.each_transaction(sku: sku) do |transaction|
      price = transaction.price
      if price.currency == currency
        grand_total += price.amount
      else
        grand_total += @converter.convert(price.amount, price.currency, currency)
      end
    end

    grand_total
  end

end
