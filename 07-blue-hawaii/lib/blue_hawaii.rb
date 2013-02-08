require 'blue_hawaii/rental_unit'

require 'pp'
require 'json'

class BlueHawaii

  def initialize(options)
    @input_path = options[:input]
    @rental_path = options[:rentals]
  end

  def solve
    raw_date_range = File.read(@input_path)
    date_range = raw_date_range.split("-").collect &:strip

    rental_data = JSON.parse File.read(@rental_path)
    
    rental_data.each do |scenario|
      rental = RentalUnit.new json: scenario
      rental_cost = rental.rental_cost *date_range
      puts "#{rental.name}: $#{rental_cost.to_s('F')}"
    end
  end
end
