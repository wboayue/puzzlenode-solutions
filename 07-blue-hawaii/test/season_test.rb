require_relative 'test_helper'

require 'blue_hawaii/season'
require 'json'
require 'pp'

describe Season do

  include TestHelper

  describe "#initialize" do
    before do
      json = %q[{"one": {"start":"05-01", "end":"05-13", "rate":"$137"}}]
      @season = Season.new JSON.parse(json)
    end

    it "should set name" do
      assert_equal "one", @season.name
    end

    it "should set start_on" do
      assert_equal MonthDay.new(5, 1), @season.start_on
    end

    it "should set end_on" do
      assert_equal MonthDay.new(5, 13), @season.end_on
    end

    it "should set rate" do
      assert_equal BigDecimal.new("137.00"), @season.rate
    end
  end

  describe "#contains?" do
    describe "single year season" do
      before do
        json = %q[{"one": {"start":"05-01", "end":"05-13", "rate":"$137"}}]
        @season = Season.new JSON.parse(json)
      end

      it "should contain these days" do
        assert @season.contains? parse_date("2012-05-01")
        assert @season.contains? parse_date("2012-05-10")
        assert @season.contains? parse_date("2012-05-13")
      end

      it "should not contain these days" do
        refute @season.contains? parse_date("2012-04-01")
        refute @season.contains? parse_date("2012-06-13")
      end
    end

    describe "multi year season" do
      before do
        json = %q[{"one": {"start":"10-15", "end":"02-10", "rate":"$137"}}]
        @season = Season.new JSON.parse(json)
      end

      it "should contain these days" do
        assert @season.contains? parse_date("2012-10-15")
        assert @season.contains? parse_date("2013-11-10")
        assert @season.contains? parse_date("2013-01-10")
        assert @season.contains? parse_date("2012-02-10")
      end

      it "should not contain these days" do
        refute @season.contains? parse_date("2012-09-10")
        refute @season.contains? parse_date("2012-03-10")
      end
    end
  end

  def parse_date(date)
    Date.strptime date, '%Y-%m-%d'
  end
end