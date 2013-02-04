require 'json'
require 'bigdecimal'

class RentalUnit

  attr_reader :name, :rate, :cleaning_fee

  TAX_RATE = BigDecimal.new "1.0411416"

  def initialize(data)
    json = JSON.parse(data)
    @name = json["name"]
    @rate = BigDecimal.new json["rate"][1..-1]
    @cleaning_fee = BigDecimal.new json["cleaning fee"][1..-1]
  end

  def has_seasons?
    false
  end

  def rental_cost(start_date, end_date)
    start_date = Date.strptime start_date, '%Y/%m/%d'
    end_date = Date.strptime end_date, '%Y/%m/%d'

    if has_seasons?
    else
      simple_rental_cost(start_date, end_date)
    end
  end

  def simple_rental_cost(start_date, end_date)
    num_days = end_date - start_date
    rental_cost = (@rate * BigDecimal.new(num_days.to_s) + @cleaning_fee) * TAX_RATE
    rental_cost.round(2)
  end

end