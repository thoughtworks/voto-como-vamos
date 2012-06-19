# language: pt
Funcionalidade: Visualizar perfil de candidato
  Como eleitor
  Eu quero ver o perfil de um candidato
  Para que eu possa ver suas informações, projetos e histórico

  Cenario: Visualizar a página do candidato
    Dado que eu estou logado na aplicação
    E que existe um candidato
    Quando eu acesso o perfil do mesmo
    Entao eu devo ver as suas informações
