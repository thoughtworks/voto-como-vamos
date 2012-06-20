# -*- encoding : utf-8 -*-
Dado /^que eu estou logado na aplicação$/ do
  @current_user = FactoryGirl.create :user
  login_with uid: @current_user.uid
end

Dado /^que existe um candidato$/ do
  @candidate = FactoryGirl.create :candidate
end

Quando /^eu acesso o perfil do mesmo$/ do
  visit candidate_path(@candidate)
end

Entao /^eu devo ver as suas informações$/ do
  page.should have_content(@candidate.name)
end

private

def login_with(mock_options = nil)
  OmniAuth.config.test_mode = true

  if mock_options == :invalid_credentials
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  elsif mock_options
    OmniAuth.config.add_mock :facebook, mock_options
  end

  visit "/auth/facebook"
end

Dado /^que existem alguns candidatos$/ do
  @candidates = []
  3.times do |i|
    @candidates << FactoryGirl.create(:candidate, name: "Candidato #{i}")
  end
end

Quando /^eu acesso a listagem de candidatos$/ do
  visit root_path
end

Entao /^eu devo ver tais candidatos$/ do
  @candidates.each do |candidate|
    page.should have_content(candidate.name)
  end
end

Quando /^escolho o perfil de um determinado candidato$/ do
  @candidate = @candidates.first
  click_link "Candidato 0"
end
