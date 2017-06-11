class AuthorizedController < ApplicationController
  before_action :require_login
end
