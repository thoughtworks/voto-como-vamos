# encoding: utf-8

class CandidateMailer < ActionMailer::Base
  default from: "admin@votocomovamos.org.br"
  
  def revindication(candidate_id, user_id)
    @candidate = Candidate.find(candidate_id)
    @user = User.find(user_id)
    mail(:to => @candidate.email, :subject => "Solicitação de Gerenciamento de Perfil")
  end

  def send_message_for_revindication(candidate_id)
    @candidate = Candidate.all.at(candidate_id)
    mail(:to => @candidate.email, :subject => "Voto Como Vamos! Reinvindique a administração do seu perfil")
  end
end
