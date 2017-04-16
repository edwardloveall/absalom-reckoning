class AddCalendarToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :calendar, index: true
  end
end
