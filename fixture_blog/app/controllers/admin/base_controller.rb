class Admin::BaseController < ApplicationController
  before_filter :authenticate
private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      @session_user = User.authenticate(username,password)
    end
  end
end
