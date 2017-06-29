class AuthorizedController < ApplicationController
  class NotAuthorized < RuntimeError; end

  before_action :require_login

  rescue_from NotAuthorized, with: :not_authorized

  def not_authorized
    flash[:error] = I18n.t('helpers.error.no_permission')
    redirect_to calendar_path(calendar)
  end

end
