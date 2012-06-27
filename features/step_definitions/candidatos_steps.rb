# -*- encoding : utf-8 -*-

def login_with(mock_options = nil)
  OmniAuth.config.test_mode = true

  if mock_options == :invalid_credentials
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  elsif mock_options
    OmniAuth.config.add_mock :facebook, mock_options
  end

  visit "/auth/facebook"
end

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
  [
    :alliance, :about, :name, :party
  ].each do |field|
    page.should have_content(@candidate.send(field))
  end
end

Dado /^que existem alguns candidatos$/ do
  @candidates = 3.times.map { |i| FactoryGirl.create(:candidate) }
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
  click_link @candidate.name
end

Dado /^que estou na minha página de candidato ou do candidato que acessoro$/ do
  @candidate = FactoryGirl.create :candidate
  visit candidate_path(@candidate)
end
Quando /^reinvindico propriedade sobre ela$/ do
  click_link "Sou esse candidato"
end

Quando /^aceito os termos de uso da aplicação$/ do
  check "Aceito os Termos e Condições"
end

Quando /^confirmo a solicitação$/ do
  click_button "Confirmar"
end

Então /^devo ver que minha solicitação foi feita$/ do
  page.should have_content("Solicitação realizada com sucesso")
end

Então /^o candidato em seu e\-mail oficial deve receber pedido de validação$/ do
  @email = ActionMailer::Base.deliveries.first
  @email.from.should == ["admin@votocomovamos.org.br"]
  @email.to.should == [@candidate.email]
  @email.body.should include("O usuário #{@current_user.name} está requisitando permissão para administrar seu perfil")
end
