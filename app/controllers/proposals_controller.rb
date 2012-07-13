# encoding: utf-8
require "components/opinion_widget"

class ProposalsController < ApplicationController
  before_filter :load_candidate, :except => [:index, :show]

  def index
    @proposals = Proposal.search(params[:query], params[:categories])
  end

  def show
    @proposal = Proposal.find(params[:id])
    @candidate = @proposal.candidate
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

  def edit
    @proposal = find_proposal
  end

  def update
    @proposal = find_proposal
    if @proposal.update_attributes(params[:proposal])
      redirect_to candidate_path(@candidate.id),
        :notice => I18n.t('proposals.edit.success')
    else
      render :edit
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

  def find_proposal
    proposals = @candidate.proposals
    proposals.find(params[:id])
  end
end
