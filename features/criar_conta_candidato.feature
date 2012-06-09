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

  @pending @smoke
  Cenario: Solicitando Cadastro
    Dado que eu estou na home page do Votar Como Vamos
    Quando eu pesquiso pela minha conta
    Entao eu sou direcionado para a página de reinvidicação de conta de candidatos
    E as seguintes sessões habilitadas:
      | Home                   | 
      | Informações Básicas    | 
      | Redes Sociais          | 
      | TERMOS DE USO          | 
      | Propostas              |
      | Perguntas e respostas  | 
      | Dados da campanha      |
      | Agenda Pública         |
      | Gastos e despesas      |
      | Arrecadações e Doações |
      | Contato                | 
      | Publicidade            | 
      | Popularidade           | 
      | Preview                | 
    Quando eu solicito ir para a página de informações básicas 
    Entao eu devo ver os seguintes campos para cadastro:
      | Nome eleitoral                       | 
      | Número de Candidato                  |
      | Avatar                               |
      | login                                | 
      | Senha                                | 
      | Confirmação de Senha                 | 
      | Nome                                 | 
      | Sobrenome                            | 
      | E-mail                               | 
      | Partito                              | 
      | Candidato para                       | 
      | Telefone para ativação do cadastro   | 
      | Bio                                  |
    E preencho os campos com os valores:
      | Nome eleitoral                       | Zé da redenção                       | 
      | Número de Candidato                  | 0000000                              | 
      | login                                | zeredencao                           | 
      | Senha                                | Zered00*poa123                       | 
      | Confirmação de Senha                 | Zered00*poa123                       | 
      | Nome                                 | José                                 | 
      | Sobrenome                            | Nascimento                           | 
      | E-mail                               | jose@meupartido.gov.br               | 
      | Partito                              | POA                                  | 
      | Candidato para                       | Vereador                             | 
      | Telefone para ativação do cadastro   | 051 1234-4321                        | 
      | Bio                                  | Representante dos fracos e oprimidos | 
    Quando solicito salvar
    Entao eu devo ver a mensagem:
      | Atenção: Esse cadastro não poderá ser modificado. Deseja continuar?   |
    Quando eu informo que sim
    Entao o sistema valida se todos os campos foram preenchidos
    E redireciona para a página de Redes Sociais
    E eu devo ver os seguintes campos de cadastro:
      | Link para Curtir no Facebook | 
      | Facebook                     | 
      | Facebook Fan Page            | 
      | Twitter                      | 
      | Blog                         | 
      | Site de Campanha             | 
      | Site Pessoal                 | 
      | Orkut                        | 
      | LinkedIn                     | 
      | URL 1                        | 
      | Descrição da URL 1           | 
      | URL 2                        | 
      | Descrição da URL 2           | 
      | URL 3                        | 
      | Descrição da URL 3           | 
      | URL 4                        | 
      | Descrição da URL 4           | 
    Quando eu solicito salvar
    Entao eu devo ver a mensagem:
      | Atenção: Esse cadastro não poderá ser modificado. Deseja continuar?   |
    Quando eu informo que sim
    Entao o sistema valida se todos os campos de redes sociais foram preenchidos
    E redireciona para a página de Termos de uso
    E os termos de uso devem ser exibidos
    Quando eu marco o campo aceito
    Entao o sistema deve habilitar o campo Finalizar Cadastro
    Quando eu clicar no botão finalizar Cadastro
    Entao o sistema deve exibir a mensagem:
      |Obrigado pelo Cadastro. Cadastro submetido com sucesso, entraremos em contato o mais breve possível para ativação|

 @pending
 Cenario: Opções de candidatos
    Dado que eu estou na página de informações básicas de candidatos
    Entao eu devo ver as seguintes opções para se candidatar:
      | Deputado Estadual       | 
      | Deputado Federal        | 
      | Presidente da Republica | 
      | Vereador                | 
      | Prefeito                | 
      | Governador              | 
      | Senador                 | 

  @pending
  Esquema do Cenario: Obrigatoriedade dos campos de informações Básicas
    Dado que eu estou na página de informações básicas de candidatos
    E todos os campos estão preenchidos
    Quando eu removo o campo:
      | Nome eleitoral                       | 
      | Número de Candidato                  |
      | Avatar                               |
      | login                                | 
      | Senha                                | 
      | Confirmação de Senha                 | 
      | Nome                                 | 
      | Sobrenome                            | 
      | E-mail                               | 
      | Partito                              | 
      | Candidato para                       | 
      | Telefone para ativação do cadastro   | 
      | Bio                                  |
    E solicito salvar
    Entao eu devo ver a mensagem:
      |Gentileza preencher todos os campos para prosseguir|

  @pending
  Esquema do Cenario: Requisitos de segurança da senha
    Dado que eu estou na página de informações básicas de candidatos
    E todos os campos estão preenchidos
    Quando eu preencho o campo senha com o valor:
      | teste12345678890        |
      | SenhaFraca123           |
      | A&*D92iu*9s             |
      | !@#$%&*%$#@!@#$#@!@#$   |
    Entao eu devo ver a mensagem:
      | A senha precisa ter no mínimo doze caracteres, ser alphanumerica e possuir pelo menos um simbolo (!@#$%&*)|

  @pending
  Cenario: Cadastrando candidato com login duplicado
    Dado que eu estou na página de informações básicas de candidatos
    E todos os campos estão preenchidos
    Quando eu informo um login ja existente
    E solicito salvar
    Entao eu devo ver a mensagem:
      | O login solicitado ja existe, gentileza informa um novo login |

  @pending
  Cenario: Cadastrando candidato com legenda duplicada
    Dado que eu estou na página de informações básicas de candidatos
    E todos os campos estão preenchidos
    Quando eu informo uma legenda ja existente
    E solicito salvar
    Entao eu devo ver a mensagem:
      | O legenda informada está sendo usada, gentileza entrar em contato conosco pelo email "contato@votocomovamos.com" |
