# language: pt
Funcionalidade: Editar perfil candidato
  Como candidato 
  Quero editar informações do meu perfil 
  Para garantir a atualização das informações

  Contexto:
    Dado que eu estou logado na aplicação
    E que existe um candidato
    E que eu represento o candidato

  Cenário: Atualização de perfil com sucesso
    Quando o candidato editar seu perfil
    E alterar o campo Sobre Mim para 'Candidato muito engajado em causas sociais.'
    E alterar o campo Email para 'fulano@governo.br'
    E alterar o campo Telefone para '(51)9999-5555'
    E alterar o campo Site para 'http://www.fulanodetal.br'
    E alterar o campo Blog para 'http://www.fulanodetal.br/blog'
    E alterar o campo Facebook para 'http://facebook.com/Fulano.Tal'
    E alterar o campo Twitter para 'http://twitter.com/fulanodetal'
    E confirmar a alteração
    Entao ele deve ver suas informações atualizadas

  Cenário: Atualização com erro de validação
    Quando o candidato editar seu perfil
    E alterar o campo Telefone para 'invalido'
    E alterar o campo Email para 'invalido'
    E confirmar a alteração
    Entao ele deve ver uma mensagem de erro indicando que o campo Telefone é inválido
    E ele deve ver uma mensagem de erro indicando que o campo Email é inválido

  Cenário: Informando que o perfil é controlado por acessoria de imprensa
    Quando o candidato editar seu perfil
    E marcar 'Sim' no campo Acessoria de Imprensa
    E confirmar a alteração
    Então ele deve ver suas informações atualizadas
    E ele deve ser uma mensagem informando que seu perfil é gerenciado pela acessoria de imprensa

  Cenário: Informando que o perfil é controlado pelo Candidato
    Quando o candidato editar seu perfil
    E marcar 'Não' no campo Acessoria de Imprensa
    E confirmar a alteração
    Então ele deve ver suas informações atualizadas
    E ele deve ser uma mensagem informando que seu perfil é gerenciado pelo candidato

