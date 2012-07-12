class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  def create
    user = User.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    user ||= set_ensure_canvas && User.create_with_auth(auth_hash)
    session[:user_id] = user.id

    redirect_to session.delete(:return_to) and return if (session[:return_to] && session[:return_to] != root_path)

    redirect_to ensure_canvas? ? Settings.facebook_app_url : root_path
  end

  private

  def ensure_canvas?
    @canvas
  end

  def set_ensure_canvas
    @canvas = true
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
