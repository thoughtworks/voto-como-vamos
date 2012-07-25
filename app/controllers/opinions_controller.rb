class OpinionsController < ApplicationController
  before_filter :authenticate!

  def create
    Opinion.create params_for_current_user, :as => :admin
    redirect_to :back 
  end

  def new
    create
  end

  def destroy
    opinion = Opinion.where(:user_id => current_user.id, :id => params[:id]).first
    opinion.destroy
    redirect_to :back
  end

  def update
    opinion = Opinion.where(:user_id => current_user.id, :id => params[:id]).first
    opinion.update_attributes value: params[:opinion][:value]
    redirect_to :back
  end

  def edit
    update
  end

  private
  def params_for_current_user
    params[:opinion].merge(user_id: current_user.id)
  end
end
