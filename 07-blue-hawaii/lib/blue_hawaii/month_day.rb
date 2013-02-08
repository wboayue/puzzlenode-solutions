class MonthDay
  
  attr_reader :month, :day

  def initialize(month, day)
    @month = month.to_i
    @day = day.to_i
  end

  def ==(o)
    o.month == month && o.day == day
  end

  def before_or_on(date)
    month < date.month || (month == date.month && day <= date.day) 
  end

  def after_or_on(date)
    month > date.month || (month == date.month && day >= date.day) 
  end

end