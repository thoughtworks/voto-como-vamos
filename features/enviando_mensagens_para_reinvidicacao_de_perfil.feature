# language: pt
Funcionalidade: Enviando mensagens para reivindicação de perfil 

  Cenario: Enviando solicitação de reivindicação de administração de e-mail
    Dado que existem alguns candidatos válidos
    Quando solicitamos envio de reivindicação de perfil em massa
    Entao todos os candidatos devem receber um e-mail com a solicitação
