class OwnershipsController < ApplicationController
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
    @candidate = Candidate.find_by_obfuscated_slug!(params[:candidate_id])
  end
end
