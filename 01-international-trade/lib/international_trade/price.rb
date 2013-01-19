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
      Price.new(amount + other.amount, currency)
    else
      Price.new(amount + CurrencyConverter.convert(other.amount, other.currency, currency), currency)
    end
  end

  def to_s
    "#{@amount.round(2).to_s('F')} #{currency}"
  end

end