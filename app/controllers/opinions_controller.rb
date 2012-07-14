class OpinionsController < ApplicationController

  def create
    Opinion.create params_for_current_user, :as => :admin
    redirect_to proposal_path params[:opinion][:proposal_id]
  end

  def new
    create
  end

  def destroy
    opinion = Opinion.where(:user_id => current_user.id, :id => params[:id]).first
    opinion.destroy
    redirect_to proposal_path opinion.proposal_id
  end

  def update

  end

  def edit

  end

  private
  def params_for_current_user
    params[:opinion].merge(user_id: current_user.id)
  end
end
