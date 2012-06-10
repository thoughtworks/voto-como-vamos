#language: pt
Funcionalidade: Autenticar Usuário
  Como usuário do facebook
  Eu desejo me autenticar no Votar Como Vamos
  Para que eu possa dar minha opinião a respeito de propostas e candidatos

  @javascript
  Cenario: Usuário existente
    Dado que sou um usuário já cadastrado no Votar Como Vamos
    Quando eu acesso a página principal
    Então devo ser autenticado com sucesso

  @javascript @wip
  Cenario: Novo usuário
    Dado que sou um usuário não cadastrado no Votar Como Vamos
    Quando eu acesso a página principal
    E confirmo o pedido de autorização
    Então devo ser autenticado com sucesso
