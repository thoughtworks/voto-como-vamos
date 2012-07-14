# language: pt
Funcionalidade: Visualizar perfil de candidato
  Como eleitor
  Eu quero ver o perfil de um candidato
  Para que eu possa ver suas informações, projetos e histórico

  Cenario: Visualizar a página do candidato
    Dado que eu estou logado na aplicação
    E que existe um candidato com propostas
    Quando eu acesso o perfil do mesmo
    Entao eu devo ver as suas informações

  Cenario: Visualizar a página do candidato
    Dado que eu estou logado na aplicação
    E que existe um candidato com propostas
    Quando eu acesso o perfil do mesmo
    Entao eu devo ver as suas informações

  Cenario: Visualizar a página do candidato sem twitter
    Dado que eu estou logado na aplicação
    E que existe um candidato sem twitter com propostas
    Quando eu acesso o perfil do mesmo
    Entao eu não devo ver o twitter
    Entao eu devo ver o facebook
    Entao eu devo ver o blog
    Entao eu devo ver o site

  Cenario: Visualizar a página do candidato sem facebook
    Dado que eu estou logado na aplicação
    E que existe um candidato sem facebook com propostas
    Quando eu acesso o perfil do mesmo
    Entao eu devo ver o twitter
    Entao eu não devo ver o facebook
    Entao eu devo ver o blog
    Entao eu devo ver o site

  Cenario: Visualizar a página do candidato sem site
    Dado que eu estou logado na aplicação
    E que existe um candidato sem site com propostas
    Quando eu acesso o perfil do mesmo
    Entao eu devo ver o twitter
    Entao eu devo ver o facebook
    Entao eu devo ver o blog
    Entao eu não devo ver o site

  Cenario: Visualizar a página do candidato sem blog
    Dado que eu estou logado na aplicação
    E que existe um candidato sem blog com propostas
    Quando eu acesso o perfil do mesmo
    Entao eu devo ver o twitter
    Entao eu devo ver o facebook
    Entao eu não devo ver o blog
    Entao eu devo ver o site

