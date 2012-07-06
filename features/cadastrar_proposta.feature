# language: pt

Funcionalidade: Cadastrar Proposta
  Como um candidato
  Eu quero cadastrar minhas propostas
  Para que os eleitores possam avaliá-las e fazer perguntas

  Contexto:
    Dado que eu estou logado na aplicação
    E que eu sou um candidato cadastrado
    E que eu represento o candidato
    E que existe um macro-tema cadastrado

  Cenário: Proposta cadastrada
    Dado que eu estou cadastrando uma proposta
    Quando eu preencher todos os campos da proposta
    Então eu devo ver uma mensagem de sucesso
    E eu devo ver a página do candidato

  Cenário: Dados inválidos
    Dado que eu estou cadastrando uma proposta
    Quando eu preencher os campos da proposta com dados inválidos
    Então eu devo ver os campos que contêm erros
