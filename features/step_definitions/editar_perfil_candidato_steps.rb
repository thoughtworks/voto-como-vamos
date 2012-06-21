# -*- encoding : utf-8 -*-
Quando /^o candidato editar seu perfil$/ do
  visit edit_candidate_path(@candidate)
end

Quando /^alterar o campo email para '(.*?)'$/ do |email|
  fill_in 'Email', :with => email
  click_button 'Salvar'
end

Entao /^ele deve ver suas informações atualizadas$/ do
  page.should have_content('Perfil atualizado com sucesso')
end
