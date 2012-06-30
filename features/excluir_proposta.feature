# language: pt

Funcionalidade: Excluir Proposta
  Como um candidato
  Eu quero excluir uma proposta
  Pois ela não faz mais parte da minha lista de propostas

  Contexto:
    Dado que eu estou logado na aplicação
    E que eu sou um candidato cadastrado
    E que eu tenha uma proposta cadastrada

  Cenário: Proposta excluída
    Dado que eu estou visualizando uma proposta
    Quando eu tentar excluir a proposta
    E eu confirmar a exclusão da proposta
    Então eu devo ver uma mensagem de sucesso
    E eu devo ver a página do candidato

  Cenário: Exclusão cancelada
    Dado que eu estou visualizando uma proposta
    Quando eu tentar excluir a proposta
    E eu cancelar a exclusão da proposta
    Então eu devo ver a proposta
