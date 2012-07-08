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
    Quando eu não preencho os campos da proposta
    Entao eu devo ver uma mensagem informando que eu preciso preencher cada um dos três campos

  Cenário: Campo descrição não preenchido
    Dado que eu estou cadastrando uma proposta
    Quando eu não preencho o campo descrição
    Entao eu devo ver uma mensagem informando que o campo descrição é obriatório 

  Cenário: Campo titulo não preenchido
    Dado que eu estou cadastrando uma proposta
    Quando eu não preencho o campo titulo
    Entao eu devo ver uma mensagem informando que o campo titulo é obriatório 

  Cenário: Campo abstract não preenchido
    Dado que eu estou cadastrando uma proposta
    Quando eu não preencho o campo abstract
    Entao eu devo ver uma mensagem informando que o campo abstract é obriatório 

  @pending
  Cenario: Tamanho do titulo muito grande
    Dado que eu estou cadastrando uma proposta
    Quando eu preencho um titulo com muitos caracteres
    Entao eu devo ver uma mensagem informando que o titulo é inválido

  Cenario: Tamanho do abstract muito grande
    Dado que eu estou cadastrando uma proposta
    Quando eu preencho um abstract com muitos caracteres
    Entao eu devo ver uma mensagem informando que o abstract é inválido

  @pending
  Cenario: Tamanho do descrição muito grande
    Dado que eu estou cadastrando uma proposta
    Quando eu preencho um descrição com muitos caracteres
    Entao eu devo ver uma mensagem informando que o descrição é inválido
