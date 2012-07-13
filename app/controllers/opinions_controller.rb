class OpinionsController < ApplicationController

  def create
    Opinion.create params_for_current_user, :as => :admin
    redirect_to proposal_path params[:opinion][:proposal_id]
  end

  def new
    create
  end

  private
  def params_for_current_user
    params[:opinion].merge(user_id: current_user.id)
  end
end
