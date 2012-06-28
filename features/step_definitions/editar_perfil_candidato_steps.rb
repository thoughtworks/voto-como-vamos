# -*- encoding : utf-8 -*-
Quando /^o candidato editar seu perfil$/ do
  visit edit_candidate_path(@candidate)
end

Quando /^alterar o campo (.*?) para '(.*?)'$/ do |field_name, about|
 fill_in field_name, :with => about
end

Quando /^marcar '(.*?)' no campo Acessoria de Imprensa$/ do |option|
  choose option
end

Quando /^confirmar a alteração$/ do
  click_button 'Salvar'
end

Entao /^ele deve ver suas informações atualizadas$/ do
  page.should have_content('Perfil atualizado com sucesso')
end

Entao /^ele deve ver uma mensagem de erro indicando que o campo (.*?) é inválido$/ do |nome_do_campo|
  page.should have_css(".error", :text => nome_do_campo )
end

Então /^ele deve ser uma mensagem informando que seu perfil é gerenciado pela acessoria de imprensa$/ do
  page.should have_content('Este perfil é gerenciado pela Acessoria de Imprensa')
end

Então /^ele deve ser uma mensagem informando que seu perfil é gerenciado pelo candidato$/ do
  page.should have_content('Este perfil é gerenciado pelo Candidato')
end