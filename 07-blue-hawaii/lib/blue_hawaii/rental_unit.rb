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
    start_date = parse_date(start_date)
    end_date = parse_date(end_date)

    if has_seasons?
      compute_complex_rental_cost(start_date, end_date)
    else
      compute_simple_rental_cost(start_date, end_date)
    end
  end

  private 

  def compute_simple_rental_cost(start_date, end_date)
    num_days = end_date - start_date
    rental_cost = (@rate * BigDecimal.new(num_days.to_s) + @cleaning_fee) * TAX_RATE
    rental_cost.round(2)
  end

  def compute_complex_rental_cost(start_date, end_date)
    rental_cost = seasons.inject(0) {|sum, season| sum + season.rental_cost(start_date, end_date)}
    rental_cost = (rental_cost + @cleaning_fee) * TAX_RATE
    rental_cost.round(2)
  end

  def parse_date(date)
    Date.strptime date, '%Y/%m/%d'
  end

end