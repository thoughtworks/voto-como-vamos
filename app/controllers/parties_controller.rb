# encoding: utf-8
class PartiesController < ApplicationController

  def index
    @parties = Candidate.select('distinct party').map { |c| c.party }
  end

  def show
    @party = params[:id]
    @candidates = Candidate.where(:party => @party).order(:short_name)
  end

  private
  def body_class
    "fundovermelho"
  end

end
