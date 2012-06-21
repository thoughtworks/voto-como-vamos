# language: pt

Funcionalidade: Cadastrar Proposta
  Como um candidato
  Eu quero cadastrar minhas propostas
  Para que os eleitores possam avaliá-las e fazer perguntas

  Contexto:
    Dado que eu estou logado na aplicação
    E que eu sou um candidato cadastrado

  Cenário: Proposta cadastrada
    Dado que eu estou cadastrando uma proposta
    Quando eu preencher todos os campos da proposta
    Entao a proposta deve ser salva
    E eu devo ver meu perfil

  Cenário: Dados inválidos
    Dado que eu estou cadastrando uma proposta
    Quando eu preencher os campos da proposta com dados inválidos
    Entao a proposta não deve ser salva
    E eu devo ver os campos que contem erros
