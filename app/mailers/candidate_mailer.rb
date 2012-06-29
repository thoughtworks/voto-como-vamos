# encoding: utf-8
class CandidateMailer < ActionMailer::Base
  default from: "admin@votocomovamos.org.br"
  
  def revindication(candidate_id)
    candidate = Candidate.find(candidate_id)
    mail(
      :to => candidate.email, 
      :subject => "Voto Como Vamos! Reinvindique a administração do seu perfil"
    )
  end
end
