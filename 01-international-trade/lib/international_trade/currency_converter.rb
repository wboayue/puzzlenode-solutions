class CurrencyConverter

  def initialize(data_file)
    @conversions = load_conversions(data_file)
  end

  def load_conversion(data_file)
  end
  
  def supports?(from, to)
    return true
  end

end