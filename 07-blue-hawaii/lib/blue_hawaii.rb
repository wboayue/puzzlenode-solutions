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
    pp raw_date_range

    date_range = raw_date_range.split("-").collect &:strip

    rental_data = JSON.parse File.read(@rental_path)
    
    rental_data.each do |scenario|
      pp scenario
      rental = RentalUnit.new json: scenario
      rental_cost = rental.rental_cost *date_range
      puts "#{rental.name}: $#{ '%.2f' % rental_cost}"
    end
  end
end
