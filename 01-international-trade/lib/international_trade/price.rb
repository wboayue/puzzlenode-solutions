class Price

  attr_reader :amount, :currency

  def initialize(amount, currency)
    @amount = BigDecimal.new(amount.to_s)
    @currency = currency.downcase.to_sym
  end

  def to_s
    "#{@amount.round(2).to_s('F')} #{currency}"
  end

end