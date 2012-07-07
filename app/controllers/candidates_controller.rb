# encoding: utf-8
class CandidatesController < ApplicationController
  before_filter :candidate, :except => [:index]
  before_filter :authorize_candidate, :only => [:edit, :update]

  def index
    if params[:query].present?
      @candidates = Candidate.search(params[:query], :load => true)
    else
      @candidates = Candidate.all
    end
  end

  def show
  end

  def edit
  end

  def update
    if @candidate.update_attributes(params[:candidate])
      redirect_to candidate_path(@candidate.id), 
        :notice => "Perfil atualizado com sucesso"
    else
      render :edit
    end
  end

  private
  def authorize_candidate
    unless current_user.represents? @candidate
      redirect_to root_path
    end
  end

  def candidate
    @candidate = Candidate.find(params[:id])
  end
end
