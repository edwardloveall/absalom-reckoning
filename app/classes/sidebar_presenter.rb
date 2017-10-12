class SidebarPresenter < Keynote::Presenter
  presents :user

  def invitation_link
    if Invitation.exists?(email: user.email)
      link_to('Invitations', invitations_path, class: 'action')
    end
  end
end
