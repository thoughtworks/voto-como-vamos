class CommentsController < ApplicationController
  before_filter :load_proposal
  before_filter :authenticate!

  def create
    comment = Comment.new(:fb_comment_id => params[:id])
    comment.proposal = @proposal
    comment.user = current_user
    if comment.save
      render :json => { :success => true }, :status => :ok
    else
      render :json => { :success => false}, :status => :bad_request
    end
  end

  private

  def load_proposal
    @proposal = Proposal.find(params[:proposal_id])
  end
end
