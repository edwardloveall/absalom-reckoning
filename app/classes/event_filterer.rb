class EventFilterer
  attr_accessor :events

  def initialize(events)
    @events = events
  end

  def for(date:)
    events.select { |event| event.occurred_on == date }
  end
end
