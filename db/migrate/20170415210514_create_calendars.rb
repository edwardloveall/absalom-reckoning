class CreateCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :calendars do |t|
      t.timestamps
      t.string :title
    end
  end
end
