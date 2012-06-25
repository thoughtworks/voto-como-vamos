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
    if @candidate.update_attributes(params[:candidate])
      redirect_to candidate_path(@candidate.id), :notice => "Perfil atualizado com sucesso"
    else
      render :edit
    end
  end
end
