class OwnershipsController < ApplicationController
  skip_before_filter :authenticate!
  before_filter :authenticate_outside_canvas!

  def new
  end
  
  private 

  def authenticate_outside_canvas!
    unless current_user
      session[:return_to] = request.fullpath
      redirect_to '/auth/facebook'
    end
  end
end
