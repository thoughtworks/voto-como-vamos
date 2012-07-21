# language: pt
Funcionalidade: Busca Geral
  Como eleitor
  Eu quero poder buscar por candidatos e propostas de uma forma unificada
  Para que possa ver suas informações, projetos e histórico

  Cenario: Buscando entre candidatos e propostas
    Dado que eu estou logado na aplicação
    E que tenho um candidato com nome João
    E que tenho uma proposta relacionada às festividades de São João
    E que tenho um candidato com nome José
    E que tenho uma proposta relacionada às festividades de São Pedro
    Quando eu pesquiso por João
    Então devo ver tal candidato com nome João
    E devo ver a proposta relacionada às festividades de São João
    E não devo ver o candidato com nome José
    E não devo ver a proposta relacionada às festividades de São Pedro
