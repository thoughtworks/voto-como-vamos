#language: pt
Funcionalidade: Autenticar Usuário
  Como usuário do facebook
  Eu desejo me autenticar no Voto Como Vamos
  Para que eu possa dar minha opinião a respeito de propostas e candidatos

  @javascript @pending
  Cenario: Usuário existente
    Dado que sou um usuário já cadastrado no Voto Como Vamos
    E que estou logado no facebook
    Quando eu acesso a página principal
    Então devo ser autenticado com sucesso

  @javascript @pending
  Cenario: Novo usuário
    Dado que sou um usuário não cadastrado no Voto Como Vamos
    E que estou logado no facebook
    Quando eu acesso a página principal
    E confirmo o pedido de autorização
    Então devo ser autenticado com sucesso
