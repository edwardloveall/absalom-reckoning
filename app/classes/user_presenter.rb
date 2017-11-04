class UserPresenter < Keynote::Presenter
  presents :user

  def session_actions
    build_html do
      ul class: :session do
        li { link_to user.email, '' }
        li do
          link_to(
            t('helpers.submit.session.destroy'),
            session_path,
            method: :delete
          )
        end
      end
    end
  end
end
