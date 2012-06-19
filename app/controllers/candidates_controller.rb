class CandidatesController < ApplicationController
  def show
    @candidate = Candidate.find(params[:id])
  end
end
