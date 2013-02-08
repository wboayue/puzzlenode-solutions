require 'blue_hawaii/month_day'
require 'bigdecimal'

class Season

  attr_reader :name, :rate, :start_on, :end_on

  def initialize(data)
    @name = data.keys.first
    @rate = BigDecimal.new data[@name]["rate"][1..-1]
    @start_on = MonthDay.new *data[@name]["start"].split("-")
    @end_on = MonthDay.new *data[@name]["end"].split("-")
  end

  def rental_cost(start_date, end_date)
    cost = BigDecimal.new "0"
    start_date.upto(end_date - 1) do |date|
      cost += rate if contains?(date)
    end
    cost
  end

  def contains?(date)
    if end_on.month < start_on.month
      start_on.before_or_on(date) || end_on.after_or_on(date)
    else
      start_on.before_or_on(date) && end_on.after_or_on(date)
    end
  end
  
end