# encoding: utf-8
require "components/opinion_widget"

class QuestionsController < ApplicationController

  def create
    @proposal = Proposal.find params[:proposal_id]
    @question = Question.new params[:question]
    @question.proposal = @proposal
    if @question.save
      redirect_to proposal_path(@proposal)
    else
      render "proposal/show"
    end
  end
end