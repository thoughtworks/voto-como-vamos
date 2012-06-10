class SessionsController < ApplicationController
  skip_before_filter :authenticate!
  
  def create
    user = User.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    user ||= set_canvas && User.create_with_auth(auth_hash) 
    session[:user_id] = user.id
    redirect_to @canvas ? root_path(:canvas => true) : root_path
  end

  def destroy
    session[:user_id] = nil
    render :text => 'Session Destroyed'
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
  
  def set_canvas
    @canvas = true
  end
end
