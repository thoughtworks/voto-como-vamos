# language: pt

@working
Funcionalidade: Listar propostas ordenadas por votos
  Como um eleitor
  Eu quero ver as propostas mais comentadas
  Para compreender as ideias de outras pessoas


  Contexto:
    Dado que eu estou logado na aplicação

  Cenário: Propostas com mais votos devem aparecer primeiro
    Dado que haja uma proposta "Proposta #1" com 2 votos
    E que haja uma proposta "Proposta #2" com 5 votos
    Quando eu for para a pagina inicial
    Então eu devo ver "Proposta #2"
    E eu devo ver "Proposta #1"
