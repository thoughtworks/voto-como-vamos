class WelcomeController < ApplicationController
  def index
    redirect_to "/auth/facebook?signed_request=#{request.params['signed_request']}"
  end
end
