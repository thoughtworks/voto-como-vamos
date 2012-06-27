
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

  O voto como vamos deve enviar um e-mail para os e-mails importados no voto como vamos, solicitando
  um perfil de acesso do facebook para administração do candidato, mediante a aceitação dos termos de uso.

  Fora de Escopo:
  ---------------
  * Cadastros secundários, bem como qualquer cadastro que venha após a Aprovação do candidato.

  Contexto:
    Dado que eu estou logado na aplicação

  @pending
  Cenario: Reinvidicando Propriedade
    Dado que as informações do candidato foram importadas do TSE
    E que o cadastro do candidato possui um e-mail válido
    Quando solicitamos envio de reinvindicação de e-mail
    Entao o candidato deve receber em seu e-mail oficial uma URL de acesso
    Quando essa URL for acessada
    Entao o candidato deve ver a pagina do candidato associada ao e-mail
    E deve ver a opção de reinvindicação da administração
    Dado que o candidato está logado com uma conta válida do Facebook
    Quando o candidato solicitar a administração
    Entao o voto como vamos deve exibir os termos de uso
    Dado que o candidato aceitou os termos de uso
    Entao o sistema deve expirar a URL
    E deve redirecioná-lo para a Página de administração de candidato

  @pending
  Cenario: Candidato não aceita os termos de uso 
    Dado que as informações do candidato foram importadas do TSE
    E que o cadastro do candidato possui um e-mail válido
    Quando solicitamos envio de reinvindicação de e-mail
    Entao o candidato deve receber em seu e-mail oficial uma URL de acesso
    Quando essa URL for acessada
    Entao o candidato deve ver a pagina do candidato associada ao e-mail
    E deve ver a opção de reinvindicação da administração
    Dado que o candidato está logado com uma conta válida do Facebook
    Quando o candidato solicitar a administração
    Entao o voto como vamos deve exibir os termos de uso
    Dado que o candidato não aceitou os termos de uso
    Entao deve redirecioná-lo para a Home Page do Voto Como Vamos

  Cenario: Reinvidicando Propriedade
    Dado que estou na minha página de candidato ou do candidato que acessoro
    Quando reinvindico propriedade sobre ela
    E aceito os termos de uso da aplicação
    E confirmo a solicitação
    Então devo ver que minha solicitação foi feita
    E o candidato em seu e-mail oficial deve receber pedido de validação

  @pending
  Cenario: Não aceitando os termos de uso
    Dado que estou na minha página de candidato ou do candidato que acessoro
    Quando reinvidico propriedade sobre ela
    E não aceito os termos de uso da aplicação
    Então não devo receber nenhuma notificação em meu e-mail oficial

  @pending
  Cenario: Validando Propriedade
    Dado que recebi uma notificação para validação de propriedade de meu perfil
    Quando eu confirmo essa solicitação
    Então o usuário solicitante deve poder editar as propriedades do meu perfil

  @pending
  Cenario: Negando propriedade
    Dado que recebi uma notificação para validação de propriedade de meu perfil
    Quando nego essa solicitação
    Então o usuário solicitante não deverá poder editar as propriedades do meu perfil
