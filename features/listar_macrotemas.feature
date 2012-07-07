# language: pt
Funcionalidade: Listar Macrotemas
  Como eleitor
  Eu quero ver a lista de macrotemas
  Para que eu possa filtrar as propostas pelos meus interesses 

  Cenario: Listar Macrotemas
    Dado que eu estou logado na aplicação
    E que existem alguns macrotemas
    Quando eu acesso a página inicial da aplicação
    Entao eu devo ver tais macrotemas

  Cenario: Acessar as propostas em um determinado macrotema
    Dado que eu estou logado na aplicação
    E que existem alguns macrotemas
    E que existem algumas propostas para cada macrotema
    E que estou na página inicial da aplicação
    Quando eu escolho determinado macrotema 
    Entao devo ver apenas propostas naquele macrotema 
