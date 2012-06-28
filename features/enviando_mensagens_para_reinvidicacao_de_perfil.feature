# language: pt
Funcionalidade: Enviando mensagens para reinvindicação de perfil 

  Cenario: Enviando solicitação de reinvindicação de administração de e-mail
    Dado que existem alguns candidatos válidos
    Quando solicitamos envio de reinvindicação de perfil em massa
    Entao todos os candidatos devem receber um e-mail com a solicitação
