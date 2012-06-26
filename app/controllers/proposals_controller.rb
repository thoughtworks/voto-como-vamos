# encoding: utf-8

class ProposalsController < ApplicationController

  respond_to :html

  def new
    @candidate = Candidate.find(params[:candidate_id])
    @proposal = Proposal.new(:candidate_id => @candidate.id)
    respond_with(@proposal)
  end

end
