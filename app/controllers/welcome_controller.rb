class WelcomeController < ApplicationController
  before_filter :ensure_canvas

  LIMIT = 10

  def index
    @categories = Category.all
    @proposals = Proposal.ordered_by_votes.limit(LIMIT)
  end

  def credits
  end

  private

  def ensure_canvas
    redirect_to Settings.facebook_app_url if params[:canvas]
  end
end
