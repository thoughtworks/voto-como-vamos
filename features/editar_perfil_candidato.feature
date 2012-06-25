# language: pt
Funcionalidade: Editar perfil candidato
  Como candidato 
  Quero editar informações do meu perfil 
  Para garantir a atualização das informações

  Cenario: Atualização de perfil com sucesso
    Dado que eu estou logado na aplicação
    E que existe um candidato
    Quando o candidato editar seu perfil
    E alterar o campo Sobre Mim para 'Candidato muito engajado em causas sociais.'
    E alterar o campo Email para 'fulano@governo.br'
    E alterar o campo Telefone para '(51)9999-5555'
    E alterar o campo Site para 'www.fulanodetal.br'
    E alterar o campo Blog para 'www.fulanodetal.br/blog'
    E alterar o campo Facebook para 'www.facebook.com/Fulano.Tal'
    E alterar o campo Twitter para '@fulanodetal'
    E confirmar a alteração
	Entao ele deve ver suas informações atualizadas
	
  Cenario: Atualização com erro de validação
    Dado que eu estou logado na aplicação
    E que existe um candidato
	Quando o candidato editar seu perfil
	E alterar o campo Telefone para 'invalido'
	E confirmar a alteração
	Entao ele deve ver uma mensagem de erro indicando que o Phone é inválido