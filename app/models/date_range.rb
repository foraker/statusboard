class DateRange
  using Refinements::BusinessDay

  attr_accessor :start_date, :end_date

  def initialize(start_date, end_date)
    self.start_date = start_date
    self.end_date   = end_date
  end

  def weekend_seconds
    weekend_days.length * 1.day.to_i
  end

  def all_seconds
    (end_date - start_date).to_i
  end

  def business_seconds
    all_seconds - weekend_seconds
  end

  private

  def weekend_days
    date_range.select { |day| !day.business_day? }
  end

  def date_range
    start_date.to_date..end_date.to_date
  end
end
