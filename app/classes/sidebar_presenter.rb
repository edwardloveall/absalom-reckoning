class SidebarPresenter < Keynote::Presenter
  presents :user

  def invitation_link
    if Invitation.pending.where(email: user.email).present?
      link_to('Invitations', invitations_path, class: 'action')
    end
  end
end
