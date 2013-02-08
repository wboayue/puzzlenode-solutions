require_relative 'test_helper'

require 'blue_hawaii/rental_unit'
require 'json'
require 'pp'
require 'bigdecimal'

describe RentalUnit do

  include TestHelper

  describe "#initialize" do
    describe "with simple rental" do
      before do
        @rental_json = JSON.parse simple_rental_json
        @rental_unit = RentalUnit.new data: simple_rental_json
      end

      it "should assign name" do
        assert_equal @rental_json["name"], @rental_unit.name
      end

      it "should assign rate" do
        assert_equal BigDecimal.new(@rental_json["rate"][1..-1]), @rental_unit.rate
      end

      it "should assign cleaning fee" do
        assert_equal BigDecimal.new(@rental_json["cleaning fee"][1..-1]), @rental_unit.cleaning_fee
      end

      it "should not have seasons" do
        refute @rental_unit.has_seasons?
      end
    end

    describe "with complex rental" do
      before do
        @rental_json = JSON.parse complex_rental_json
        @rental_unit = RentalUnit.new data: complex_rental_json
      end

      it "should have seasons" do
        assert @rental_unit.has_seasons?
        assert_equal 2, @rental_unit.seasons.size
      end

      it "should populate season" do
        season = @rental_unit.seasons[0]

        assert_equal "one", season.name 
        assert_equal BigDecimal.new("137.00"), season.rate
        assert_equal MonthDay.new(5,1), season.start_on
        assert_equal MonthDay.new(5,13), season.end_on
      end
    end
  end

  describe "#rental_cost" do
    describe "simple rental" do
      before do
        @rental_unit = RentalUnit.new data: simple_rental_json
      end

      it "should calculate rental cost" do
        assert_equal BigDecimal.new("3508.65"), @rental_unit.rental_cost("2011/05/07", "2011/05/20")
      end
    end

    describe "complex rental" do
      before do
        @rental_unit = RentalUnit.new data: complex_rental_json
      end

      it "should calculate rental cost" do
        assert_equal "2474.79", @rental_unit.rental_cost("2011/05/07", "2011/05/20").to_s('F')
      end
    end
  end
end
