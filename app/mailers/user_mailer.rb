# encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: Settings.email_sender

  def pesquisa(user_email)
    mail(
      :to => user_email,
      :subject => "Voto Como Vamos como você quiser :)"
    )
  end
end
