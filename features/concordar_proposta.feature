# language: pt
Funcionalidade: Opinar sobre uma proposta
  Como um eleitor
  Eu quero concordar ou discordar de uma proposta 
  Para que a comunidade obtenha um "feedback" sobre cada proposta.


  Contexto:
    Dado que eu estou logado na aplicação
    E que existe um macro-tema cadastrado
    E que existe um candidato
    E que existe uma proposta cadastrada
    E que eu estou visualizando uma proposta 

  Cenário: Mostrar botão de concordar discordar
    Dado que eu estou visualizando uma proposta 
    Então eu tenho a opção de concordar ou discordar de uma proposta

  Cenário: Concordar com proposta
    Dado que eu queira concordar com uma proposta
    Quando eu seleciono a opção concordar
    Então a opção concordar ficará destacada apenas para mim para eu recordar minha opinião
    E minha opinião será contabilizada na contagem da opção concordar

  Cenário: Discordar com proposta
    Dado que eu queira discordar com uma proposta
    Quando eu seleciono a opção discordar
    Então a opção discordar ficará destacada apenas para mim para eu recordar minha opinião
    E minha opinião será contabilizada na contagem da opção discordar

  Cenário: Mudar de opnião discordar para concordar
    Dado que eu queria concordar com uma proposta que discordei anteriormente
    Quando eu seleciono a opção concordar
    Então a opção concordar ficará destacada apenas para mim para eu recordar minha opinião
    E a opção discordar não ficará mais destacada
    E minha opinião não fará mais parte da contagem de discordar
    E minha opinião será contabilizada na contagem da opção concordar

  Cenário: Mudar de opnião concordar para discordar
    Dado que eu queria discordar com uma proposta que concordei anteriormente
    Quando eu seleciono a opção discordar
    Então a opção discordar ficará destacada apenas para mim para eu recordar minha opinião
    E a opção concordar não ficará mais destacada
    E minha opinião não fará mais parte da contagem de concordar
    E minha opinião será contabilizada na contagem da opção discordar

  Cenário: Retirar opinião
    Dado que eu queria retirar minha opinião de uma proposta
    Quando eu seleciono novamente a opinião que eu tinha selecionado
    Então a opção não ficará mais destacada
    E a minha opinião não fará mais parte da contagem 
    E eu poderei votar no futuro em qualquer uma das duas opiniões
