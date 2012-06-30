#language: pt
Funcionalidade: Reinvindicar conta de candidato
  Como candidato
  Eu desejo reinvindicar uma conta no Votar Como Vamos
  Para que eu possa compartilhar minhas informações e propostas com os eleitores

  NARRATIVA:
  ==========

  Esta Feature implementa a reinvindicação de uma conta de candidato e a submissão da ficha completa
  que contem as informações importadas do candidato tse, as informações básicas, os links de redes sociais
  e os termos de uso que da aplicação Votar Como Vamos.

  O voto como vamos deve enviar uma mensagem para os e-mails importados no voto como vamos, solicitando
  um perfil de acesso do facebook para administração do candidato, mediante a aceitação dos termos de uso.

  Fora de Escopo:
  ---------------
  * Cadastros secundários, bem como qualquer cadastro que venha após a Aprovação do candidato.

  @javascript
  Cenario: Recebendo e-mail de reinvidicação de propriedade
    Dado que o Voto Como Vamos me enviou um e-mail solicitando que eu administre meu peril
    Quando acesso endereço de solicitação fornecido no e-mail 
    E entro com minhas credenciais no facebook
    Então devo ir para aceitação dos termos de uso

  @javascript
  Cenario: Me tornando administrador do meu perfil de candidato
    Dado que sou um usuário já cadastrado no Votar Como Vamos
    E que estou logado no facebook
    E que estou na página de solicitação de administração do meu perfil
    Quando aceito os termos de uso
    E confirmo a solicitação
    Então devo poder administrar o meu perfil
