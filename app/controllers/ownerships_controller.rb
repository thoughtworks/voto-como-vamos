class OwnershipsController < ApplicationController
  skip_before_filter :authenticate!
  before_filter :authenticate_outside_canvas!
  before_filter :load_candidate

  def new
    @ownership = Ownership.new 
  end

  def create
    @ownership = Ownership.new(params[:ownership])
    @ownership.user = current_user
    @ownership.candidate = @candidate
    if @ownership.save
      redirect_to edit_candidate_path(@candidate)
    else
      render :new
    end
  end
  
  private 

  def load_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end

  def authenticate_outside_canvas!
    unless current_user
      session[:return_to] = request.fullpath
      redirect_to '/auth/facebook'
    end
  end
end
