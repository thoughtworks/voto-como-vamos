# language: pt
Funcionalidade: Visualizar proposta
  Como eleitor
  Eu quero ver os detalhes de uma proposta
  Para que eu possa dar minha opinião sobre a mesma

  Cenario: Visualizar proposta
    Dado que eu estou logado na aplicação
    E que existe uma proposta cadastrada
    Quando peço pra visualizar a proposta
    Então devo ver as informações da proposta 
