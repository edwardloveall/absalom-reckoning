class AddCurrentDayToCalendars < ActiveRecord::Migration[5.1]
  def change
    default_day = ArDate.new.day_number
    add_column(
      :calendars,
      :current_date,
      :integer,
      default: default_day,
      null: false
    )
  end
end
