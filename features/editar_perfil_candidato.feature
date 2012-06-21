# language: pt
Funcionalidade: Editar perfil candidato
  Como candidato 
  Quero editar informações do meu perfil 
  Para garantir a atualização das informações

  Cenario: Alteração de email
    Dado que eu estou logado na aplicação
    E que existe um candidato
    Quando o candidato editar seu perfil
    E alterar o campo email para 'fulano@governo.br'
	Entao ele deve ver suas informações atualizadas