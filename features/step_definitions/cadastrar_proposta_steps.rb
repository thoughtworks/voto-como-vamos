# encoding: utf-8

Dado /^que eu sou um candidato cadastrado$/ do
  @candidate = FactoryGirl.create(:candidate)
end

Dado /^que eu estou cadastrando uma proposta$/ do
  visit new_candidate_proposal_path(@candidate)
end

Quando /^eu preencher todos os campos da proposta$/ do
  pending
end

Entao /^a proposta deve ser salva$/ do
  pending
end

Entao /^eu devo ver meu perfil$/ do
  pending
end

Quando /^eu preencher os campos da proposta com dados inválidos$/ do
  pending
end

Entao /^a proposta não deve ser salva$/ do
  pending
end

Entao /^eu devo ver os campos que contem erros$/ do
  pending
end
