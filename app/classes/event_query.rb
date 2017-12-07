class EventQuery
  def self.visible_to(user, from:)
    calendar = from
    if user.can_own?(calendar)
      calendar.events
    else
      calendar.events.visible
    end
  end
end
