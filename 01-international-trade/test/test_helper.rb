module TestHelper
  
  def sample_rates
    {
      aud: {cad: BigDecimal.new("1.0079")},
      cad: {usd: BigDecimal.new("1.0090")},
      usd: {cad: BigDecimal.new("0.9911")}
    }     
  end

end