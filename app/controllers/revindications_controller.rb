class RevindicationsController < ApplicationController
  before_filter :load_candidate, :only => [:new, :create]

  def new
    @revindication = Revindication.new
  end

  def create
    @revindication = Revindication.new(params[:revindication])
    @revindication.user = current_user
    @revindication.candidate = @candidate

    if @revindication.save
      redirect_to revindication_path(@revindication)
    else
      render :new
    end
  end

  def show
    @revindication = Revindication.find(params[:id])
  end

  private

  def load_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end
end
