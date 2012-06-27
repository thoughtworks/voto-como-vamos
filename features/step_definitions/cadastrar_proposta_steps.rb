# encoding: utf-8

Dado /^que eu sou um candidato cadastrado$/ do
  @candidate = FactoryGirl.create(:candidate)
end

Dado /^que eu estou cadastrando uma proposta$/ do
  visit new_candidate_proposal_path(@candidate)
end

Quando /^eu preencher todos os campos da proposta$/ do
  @proposal = Factory.build(:proposal, :candidate => @candidate)
  fill_proposal_form_with(@proposal)
end

Quando /^eu preencher os campos da proposta com dados inválidos$/ do
  @proposal = Factory.build(:invalid_proposal, :candidate => @candidate)
  fill_proposal_form_with(@proposal)
end

Entao /^eu devo ver uma mensagem de sucesso$/ do
  page.should have_selector('.alert-message.success')
end

Entao /^eu devo ver a página do candidato/ do
  current_path.should == candidate_path(@candidate)
end

Entao /^eu devo ver os campos que contêm erros$/ do
  page.should have_selector('#proposal_title + .help-inline')
  page.should have_selector('#proposal_abstract + .help-inline')
  page.should have_selector('#proposal_description + .help-inline')
end
