# language: pt
Funcionalidade: Cadastro de Candidato

  Para que os os eleitores conheçam minhas principais informações
  Como um candidato
  Eu quero cadastrar os meus dados

  Cenário: Cadastrando-se com sucesso
    Dado que preencho os dados necessários
    Quando peço para me cadastrar
    Então devo receber a confirmação de cadastro
    E ser redirecionado para meu perfil
  
  Cenário: Falhando ao se cadastrar por não preencher os dados necessários
    Dado que não preencho todos os dados necessários
    Quando peço para me cadastrar
    Então devo receber uma mensagem de erro notificando dos campos necessários


