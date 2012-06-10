class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  before_filter :authenticate!

  private  

  def current_user
    @current_user = begin
      User.find(session[:user_id]) if session[:user_id]
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end

  def authenticate!
    unless current_user
      redirect_to "/auth/facebook?signed_request=#{request.params['signed_request']}"
    end
  end
end
