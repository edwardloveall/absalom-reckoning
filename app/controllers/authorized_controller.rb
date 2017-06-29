class AuthorizedController < ApplicationController
  class NotAuthorized < RuntimeError; end
  class CalendarNotFound < RuntimeError; end

  before_action :require_login

  rescue_from NotAuthorized, with: :not_authorized
  rescue_from CalendarNotFound, with: :calendar_not_found

  def not_authorized
    flash[:error] = I18n.t('helpers.error.no_permission')
    redirect_to calendar_path(calendar)
  end

  def calendar_not_found
    flash[:notice] = I18n.t('helpers.error.calendar.not_found')
    redirect_to calendars_path
  end
end
