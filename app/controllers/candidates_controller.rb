# encoding: utf-8

class CandidatesController < ApplicationController
  def show
    @candidate = Candidate.find(params[:id])
  end

  def edit
    @candidate = Candidate.find(params[:id])
  end

  def update
    @candidate = Candidate.find(params[:id])
    @candidate.update_attributes(params[:candidate])
    redirect_to candidate_path(@candidate.id), :notice => "Perfil atualizado com sucesso"
  end
end
