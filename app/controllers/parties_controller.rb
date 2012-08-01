# encoding: utf-8
class PartiesController < ApplicationController

  def index
    @parties = Candidate.order(:party).uniq.pluck(:party)
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
