# encoding: utf-8
class CandidateMailer < ActionMailer::Base
  default from: "sistema@votocomovamos.com.br"

  def claim(candidate_id)
    @candidate = Candidate.find(candidate_id)
    mail(
      :to => @candidate.email,
      :subject => "Voto Como Vamos! Reivindique a administração do seu perfil"
    )
  end

  def notify_comment(proposal_id)
    @proposal = Proposal.find(proposal_id)
    @candidate = @proposal.candidate
    mail(
      :to => @candidate.email,
      :subject => "Voto Como Vamos! Sua proposta foi comentada"
    )
  end
end
