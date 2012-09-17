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
end
