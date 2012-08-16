# language: pt
Funcionalidade: Listar Candidatos
  Como eleitor
  Eu quero ver a lista de candidatos
  Para que eu possa ver suas informações, projetos e histórico

  Cenario: Listar Candidatos
    Dado que eu estou logado na aplicação
    E que existem alguns vereadores
    E que existem alguns prefeitos
    Quando eu acesso a listagem de candidatos
    Entao eu devo ver tais candidatos ordenados por cargo e nome

  Cenario: Acessar a página do candidato através da listagem
    Dado que eu estou logado na aplicação
    E que existem alguns vereadores
    Quando eu acesso a listagem de candidatos
    E escolho o perfil de um determinado candidato
    Entao eu devo ver a página do candidato
