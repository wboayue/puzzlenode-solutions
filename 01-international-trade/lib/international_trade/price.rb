class Price

  attr_reader :amount, :currency

  def initialize(amount, currency)
    @amount = BigDecimal.new(amount.to_s)
    @currency = currency.downcase.to_sym
  end

  def ==(other)
    (self.amount == other.amount) && (self.currency == other.currency)
  end

  def +(other)
    if currency == other.currency
      sum = amount + other.amount
    else
      sum = amount + CurrencyConverter.convert(other.amount, other.currency, currency)
    end
    Price.new(sum, currency)
  end

  def to_s
    "#{@amount.round(2).to_s('F')} #{currency}"
  end

end