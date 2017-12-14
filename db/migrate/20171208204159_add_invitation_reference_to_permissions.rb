class AddInvitationReferenceToPermissions < ActiveRecord::Migration[5.1]
  def up
    add_reference :permissions, :invitation

    Permission.find_each do |permission|
      if permission.user.nil?
        puts "skiping permission: #{permission.id}"
        next
      end

      invite = Invitation.find_by(
        email: permission.user.email,
        calendar: permission.calendar,
        level: permission.level
      )

      if invite.nil?
        puts "no invite matching permission #{permission.id}"
        next
      end

      permission.update(invitation: invite)
      puts "linked permission #{permission.id} to invitation #{invite.id}"
    end
  end

  def down
    remove_reference :permissions, :invitation
  end
end
