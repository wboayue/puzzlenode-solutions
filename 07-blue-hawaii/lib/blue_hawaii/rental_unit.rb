require 'blue_hawaii/season'

require 'json'
require 'bigdecimal'
require 'date'

class RentalUnit

  attr_reader :name, :rate, :cleaning_fee, :seasons

  TAX_RATE = BigDecimal.new "1.0411416"

  def initialize(options)
    json = options.key?(:data) ? JSON.parse(options[:data]) : options[:json]
    @name = json["name"]
    @rate = BigDecimal.new json["rate"][1..-1] if json.key? "rate"
    @cleaning_fee = json.key?("cleaning fee") ? BigDecimal.new(json["cleaning fee"][1..-1]) : BigDecimal.new("0")
    @seasons = json["seasons"].map { |data| Season.new(data) } if json.key? "seasons"
  end

  def has_seasons?
    @seasons && !@seasons.empty?
  end

  def rental_cost(start_date, end_date)
    start_date = Date.strptime start_date, '%Y/%m/%d'
    end_date = Date.strptime end_date, '%Y/%m/%d'

    if has_seasons?
      complex_rental_cost(start_date, end_date)
    else
      simple_rental_cost(start_date, end_date)
    end
  end

  def simple_rental_cost(start_date, end_date)
    num_days = end_date - start_date
    rental_cost = (@rate * BigDecimal.new(num_days.to_s) + @cleaning_fee) * TAX_RATE
    rental_cost.round(2)
  end

  def complex_rental_cost(start_date, end_date)
    rental_cost = seasons.inject(0) {|sum, season| sum + season.rental_cost(start_date, end_date)}
    rental_cost = (rental_cost + @cleaning_fee) * TAX_RATE
    rental_cost.round(2)
  end

end