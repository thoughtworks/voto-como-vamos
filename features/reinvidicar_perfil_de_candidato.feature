#language: pt

Funcionalidade: Reinvindicar conta de candidato
  Como candidato
  Eu desejo reinvindicar uma conta no Votar Como Vamos
  Para que eu possa compartilhar minhas informações e propostas com os eleitores

  NARRATIVA:
  ==========

  Esta Feature implementa a reinvindicação de uma conta de candidato e a submissão da ficha completa
  que contem a Home Page de informações do candidato, as informações básicas, os links de redes sociais
  e os termos de uso que da aplicação Votar Como Vamos, .

  Após o cadastro, o candidato deve aguardar contado da equipe Votar Como Vamos para que o seu perfil
  possa ser complementado e tenha acesso as outras sessões do cadastro, bem como ser visualizado por
  outros candidatos e eleitores. Além disso, todas as informações básicas e informações sobre redes
  sociais cadastadas pelo candidato só poderão ser editadas pela equipe do Votar Como Vamos.

  O candidato pode chegar a aplicação de várias formas, mas isso não está coberto por essa história.

  Fora de Escopo:
  ---------------
  * Validação dos campos quanto a tamanho, formato, etc.
  * Aprovação de cadastro de candidato
  * Cadastros secundários, bem como qualquer cadastro que venha após a Aprovação do candidato.
  * Acesso do candidato a está aplicação (envio de links, etc)

  Contexto:
    Dado que eu estou logado na aplicação

  @pending
  Cenario: Reinvidicando Propriedade
    Dado que estou na minha página de candidato
    Quando que reinvindico propriedade sobre ela
    E preencho as informações necessárias
    E que aceito os termos de uso da aplicação
    Então devo receber uma confirmação de que a reinvidicação foi realizada
    E os administradores da aplicação devem receber uma notificação para aprovação
