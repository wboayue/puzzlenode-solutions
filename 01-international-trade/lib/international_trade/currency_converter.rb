class CurrencyConverter

  def initialize
    @rates = RateHash.new
  end

  def load_conversion(data_file)
  end

  def supports?(from, to)
    has_chain?(from, to) || has_chain?(to, from)
  end

  def rates=(rates)
    @rates.rates = rates
  end

  private

  def has_chain?(from, to)
    !@rates[from, to].nil?
  end

end