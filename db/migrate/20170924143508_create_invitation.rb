class CreateInvitation < ActiveRecord::Migration[5.1]
  def change
    create_table :invitations do |t|
      t.timestamps
      t.belongs_to :calendar
      t.string :email, index: true
      t.string :level
      t.belongs_to :owner, index: true
    end
  end
end
