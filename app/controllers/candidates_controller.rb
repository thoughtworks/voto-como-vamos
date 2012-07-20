# encoding: utf-8
class CandidatesController < ApplicationController
  layout "verde"

  before_filter :load_candidate, :except => [:index]
  before_filter :authorize_candidate, :only => [:edit, :update]

  def index
    @candidates = Candidate.text_search(params[:query])
  end

  def show
    render :layout => "cinza"
  end

  def edit
  end

  def update
    if @candidate.update_attributes(params[:candidate])
      redirect_to candidate_path(@candidate.id), 
        :notice => I18n.t('candidates.edit.success')
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

  def load_candidate
    @candidate = Candidate.find(params[:id])
  end
end
