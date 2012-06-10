class WelcomeController < ApplicationController
  before_filter :ensure_canvas

  def index
  end

  private

  def ensure_canvas
    redirect_to Settings.facebook_app_url if params[:canvas]
  end
end
