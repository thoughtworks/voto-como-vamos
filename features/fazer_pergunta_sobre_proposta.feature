# language: pt

Funcionalidade: Fazer uma pergunta sobre uma proposta
  Como um eleitor
  Eu quero fazer uma pergunta sobre uma proposta de um candidato
  E publicar esta pergunta na minha linha do tempo
  Para esclarecer minhas dúvidas
  E compartilhar com meus amigos
  
  Contexto:
    Dado que há um candidato cadastrado
    E que este candidato registrou uma proposta
    E que eu estou logado na aplicação
    
    @pending
  Cenário: Acessar o formulário para pergunta de uma proposta
    Dado que eu estou visualizando os detalhes da proposta 
    E escrevo a pergunta "A realização dessa proposta custará quanto?"
    Quando clico no botão "Fazer Pergunta"
    Então visualizo minha pergunta no topo da lista de perguntas
    E visualizo meu nome na pergunta
