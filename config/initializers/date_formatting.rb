Date::DATE_FORMATS[:default]="%B %d, %Y"

class Date
  def as_json(options = nil)
    strftime(Date::DATE_FORMATS[:default])
  end
end
