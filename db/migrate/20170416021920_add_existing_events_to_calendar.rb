class AddExistingEventsToCalendar < ActiveRecord::Migration[5.0]
  def up
    calendar = Calendar.find_or_create_by(title: 'The Lord of the Rings')
    Event.transaction do
      Event.in_batches.each do |event_batch|
        event_batch.update_all(calendar_id: calendar.id)
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
