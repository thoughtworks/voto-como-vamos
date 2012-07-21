# language: pt
Funcionalidade: Listar Candidatos
  Como eleitor
  Eu quero ver a lista de candidatos
  Para que eu possa ver suas informações, projetos e histórico

  Cenario: Listar Candidatos
    Dado que eu estou logado na aplicação
    E que existem alguns candidatos
    Quando eu acesso a listagem de candidatos
    Entao eu devo ver tais candidatos

  @pending
  Cenario: Listar Candidatos de acordo com um determinado criterio de busca
    Dado que eu estou logado na aplicação
    E que existem alguns candidatos que atendem ao criterio de busca
    E que existem alguns candidatos que não atendem ao criterio de busca
    Quando peço para listar os candidatos de acordo com o critério de busca
    Então devo ver apenas os candidados que atendem ao criterio de busca

  Cenario: Acessar a página do candidato através da listagem
    Dado que eu estou logado na aplicação
    E que existem alguns candidatos
    Quando eu acesso a listagem de candidatos
    E escolho o perfil de um determinado candidato
    Entao eu devo ver a página do candidato
