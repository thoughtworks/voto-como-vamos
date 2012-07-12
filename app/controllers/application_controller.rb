class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  before_filter :authenticate!

  private

  def current_user
    @current_user = User.find_by_id(session[:user_id])
  end

  def authenticate!
    unless current_user
      session[:return_to] = if inside_canvas? 
        request.path
      else
        Settings.facebook_app_url + request.path
      end

      redirect_to inside_canvas? ? canvas_auth_url : outside_canvas_auth_url
    end
  end

  def outside_canvas_auth_url
    "/auth/facebook" 
  end

  def inside_canvas?
    params['signed_request']
  end

  def canvas_auth_url
    "/auth/facebook?signed_request=#{params['signed_request']}" 
  end
end
