# encoding: utf-8
class ProposalsController < ApplicationController
  before_filter :authenticate!, :except => [:index, :show, :random_listing]
  before_filter :load_candidate, :except => [:index, :show, :random_listing]
  before_filter :authorize_candidate, :except => [:index, :show, :random_listing]

  def index
    @categories = Category.find(params[:categories])
    @proposals = Proposal.search_in_categories(params[:query], params[:categories]).results.shuffle[0..4]
  end

  def random_listing
    @proposals = Proposal.all(:order => 'random()', :limit => 5)
  end

  def show
    @proposal = Proposal.find(params[:id], :include => {:questions => :user})
    @candidate = @proposal.candidate
    @question = Question.new
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

  def body_class
    "fundocinza"
  end

  def authorize_candidate
    unless @candidate.represented_by? current_user
      redirect_to root_path
    end
  end

  def load_candidate
    @candidate = Candidate.find(params[:candidate_id])
  end

  def find_proposal
    proposals = @candidate.proposals
    proposals.find(params[:id])
  end
end
