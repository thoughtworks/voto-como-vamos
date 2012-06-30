# encoding: utf-8

class ProposalsController < ApplicationController

  before_filter :load_candidate

  def show
    @proposal = Proposal.find(params[:id])
  end

  def new
    @proposal = Proposal.new(:candidate_id => @candidate.id)
  end

  def create
    @proposal = Proposal.new(params[:proposal])
    @proposal.candidate = @candidate
    if @proposal.save
      redirect_to candidate_path(@candidate),
                  :notice => I18n.t('proposals.create.success')
    else
      render :new
    end
  end

  def delete
    @proposal = Proposal.find(params[:proposal_id])
  end

  def destroy
    Proposal.find(params[:id]).delete
    redirect_to candidate_path(@candidate),
                :notice => I18n.t('proposals.destroy.success')
  end

  private
  def load_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end

end
