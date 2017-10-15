class AuthorizedController < ApplicationController
  class NotAuthorized < RuntimeError; end
  class CalendarNotFound < RuntimeError; end

  before_action :require_login

  rescue_from NotAuthorized, with: :not_authorized
  rescue_from CalendarNotFound, with: :calendar_not_found

  def not_authorized
    flash[:error] = I18n.t('helpers.error.no_permission')
    redirect_to root_path
  end

  def calendar_not_found
    redirect_to not_found_path
  end
end
