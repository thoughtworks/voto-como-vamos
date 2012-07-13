# language: pt

Funcionalidade: Autenticar usuario
  Como um candidato
  Eu quero editar apenas minhas propostas
  Para manter a autenticidade dos dados

  Contexto:
    Dado que eu estou logado na aplicação
    E que eu sou um candidato cadastrado
    E que eu represento o candidato
    E que existe um macro-tema cadastrado

  Cenário: Editar proposta de outro candidato
    Dado que outro candidato tenha uma proposta cadastrada
    Quando eu estou visualizando uma proposta
    Então eu não posso editar a proposta do outro candidato

  Cenário: Editar proposta própria
    Dado que eu tenha uma proposta cadastrada
    Quando eu estou visualizando uma proposta
    Então eu posso editar a proposta

  Cenário: Editar perfil de outro candidato
    Dado que outro candidato exista
    Quando eu estou visualizando o perfil de outro candidato
    Então eu não posso editar o perfil

  Cenário: Editar perfil do candidato
    Quando eu estou visualizando o meu perfil
    Então eu posso editar o perfil
