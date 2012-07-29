class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :body_class
  before_filter :load_search

#  unless Rails.application.config.consider_all_requests_local
#    rescue_from Exception, with: :render_500
#    rescue_from ActionController::RoutingError, with: :render_404
#    rescue_from ActionController::UnknownController, with: :render_404
#    rescue_from ActionController::UnknownAction, with: :render_404
#    rescue_from ActiveRecord::RecordNotFound, with: :render_404
#  end

  private
  def render_404(exception)
    @not_found_path = exception.message
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    @error = exception
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end

  def body_class
    "fundoazul"
  end

  def current_user
    User.find_by_id(session[:user_id])
  end

  def authenticate!
    unless current_user
      session[:return_to] = request.fullpath
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
