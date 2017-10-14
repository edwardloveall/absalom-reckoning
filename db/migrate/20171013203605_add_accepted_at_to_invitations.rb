class AddAcceptedAtToInvitations < ActiveRecord::Migration[5.1]
  def change
    add_column :invitations, :accepted_at, :datetime, index: true
  end
end
