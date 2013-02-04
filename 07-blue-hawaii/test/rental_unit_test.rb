require_relative 'test_helper'

require 'blue_hawaii/rental_unit'
require 'json'
require 'pp'
require 'bigdecimal'

describe RentalUnit do

  include TestHelper

  describe "#initialize with simple rental" do
    before do
      @rental_json = JSON.parse simple_rental_json
      @rental_unit = RentalUnit.new simple_rental_json
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

    it "should calculate rental cost" do
      assert_equal BigDecimal.new("3508.65"), @rental_unit.rental_cost("2011/05/07", "2011/05/20")
    end

  end

end
