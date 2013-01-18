class Price

  attr_reader :amount, :currency

  def initialize(amount, currency)
    @amount = BigDecimal.new(amount)
    @currency = currency.downcase.to_sym
  end

  def ==(other)
    (self.amount == other.amount) && (self.currency == other.currency)
  end

end