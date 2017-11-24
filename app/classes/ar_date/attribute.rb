class ArDate < ActiveRecord::Type::Value
  def cast(value)
    if value.is_a?(String)
      ArDateParser.from_date_string(value)
    elsif value.is_a?(Numeric)
      ArDateParser.from_day_number(value)
    else
      value
    end
  end

  def deserialize(value)
    if value.is_a?(Numeric)
      ArDateParser.from_day_number(value)
    else
      value
    end
  end

  def serialize(value)
    if value.is_a?(ArDate)
      value.day_number
    else
      value
    end
  end
end
