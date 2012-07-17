class SessionsController < ApplicationController
  skip_before_filter :authenticate!

  def create
    user = User.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    user ||= User.create_with_auth(auth_hash)
    session[:user_id] = user.id

    redirect_to session.delete(:return_to) and return if session[:return_to]
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
