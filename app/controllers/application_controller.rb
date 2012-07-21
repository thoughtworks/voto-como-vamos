class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  before_filter :authenticate!
  before_filter :load_search

  private

  def current_user
    User.find_by_id(session[:user_id])
  end

  def authenticate!
    unless current_user
      session[:return_to] = request.path
      redirect_to auth_url
    end
  end

  def auth_url
    "/auth/facebook"
  end

  def load_search
    @main_search = MainSearch.new
  end
end
