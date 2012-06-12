# language: pt
Funcionalidade: Visualizar perfil de candidato
  Como eleitor
  Eu quero ver o perfil de um candidato
  Para que eu possa ver suas informações, projetos e histórico

  Contexto: 
     | nome            | cargo    | partido | coligacao            | numero | proposta          | Descricao                |  
     | José Candidato  | Vereador | TWU     | Voto Como Vamos      | 000000 | Saúde para todos  | Candidato do povo!       |
     | Maria Candidata | Prefeito | VCV     | Chimarrão para todos | 00     |                   |                          |

  @wip
  Cenario: Visualizar a página do candidato
    Dado que eu estou logado no facebook
    Quando eu acesso o perfil de um candidato
    Entao eu devo ver a página do candidato
    E eu devo ver o breadcruamb

  @wip
  Cenario: Ver informações do candidato completo
    Dado que eu estou logado no facebook
    Quando eu acesso o perfil de um candidato
    Entao eu devo ver o nome do canditado
    E eu devo ver as informções do canditado:
      | campo      | valor                        |
      | nome       | José Candidato               |
      | cargo      | Vereador                     |
      | partido    | TWU                          |
      | coligacão  | Voto Como Vamos              |
      | número     | 000000                       |
      | propostas  | Saúde para todos             |
      | descricao  | Candidato do povo!           |

  @wip
  Cenario: Ver informações do candidato incompleto
    Dado que eu estou logado no facebook
    Quando eu acesso o perfil de um candidato
    Entao eu devo ver o nome do canditado
    E eu devo ver as informções do canditado:
       | campo      | valor                 | 
       | nome       | Maria Candidata       | 
       | cargo      | Prefeito              | 
       | partido    | VCV                   | 
       | coligacão  | Chimarrão para todos  | 
       | número     | 00                    | 
       | propostas  |                       | 
       | descricao  |                       | 
