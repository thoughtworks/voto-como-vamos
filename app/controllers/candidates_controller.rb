# encoding: utf-8
class CandidatesController < ApplicationController
  before_filter :load_candidate, :except => [:index]
  before_filter :authenticate!, :only => [:edit, :update]
  before_filter :authorize_candidate, :only => [:edit, :update]
  before_filter :fundo_verde, :except => [:show]
  before_filter :fundo_cinza, :only => [:show]

  def index
    @candidates = Candidate.text_search(params[:query], params[:page]).results
  end

  def show
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

  def fundo_verde
    @body_class = "fundoverde"
  end

  def fundo_cinza
    @body_class = "fundocinza"
  end

  def body_class
    @body_class
  end

  def authorize_candidate
    unless @candidate.represented_by? current_user
      redirect_to root_path
    end
  end

  def load_candidate
    @candidate = Candidate.find(params[:id])
  end
end
