# encoding: utf-8

class ProposalsController < ApplicationController
  before_filter :load_candidate, :only => [:new, :create]

  def new
    @proposal = Proposal.new(:candidate_id => @candidate.id)
  end

  def create
    @proposal = Proposal.new(params[:proposal])
    @proposal.candidate = @candidate
    if @proposal.save
      redirect_to candidate_path(@candidate), :notice => I18n.t('proposals.create.success')
    else
      render :new
    end
  end

  private
  def load_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end

end
