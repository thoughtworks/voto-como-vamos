# encoding: utf-8

class CandidateMailer < ActionMailer::Base
  default from: "admin@votocomovamos.org.br"
  
  def revindication(candidate_id, user_id)
    @candidate = Candidate.find(candidate_id)
    @user = User.find(user_id)
    mail(:to => @candidate.email, :subject => "Solicitação de Gerenciamento de Perfil")
  end
end
