class AddHiddenToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column(
      :events,
      :hidden_at,
      :datetime,
      index: true,
      default: Time.current
    )
  end
end
