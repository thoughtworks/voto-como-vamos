# -*- encoding : utf-8 -*-

Dado /^que sou um usuário já cadastrado no Votar Como Vamos$/ do
  test_users = Koala::Facebook::TestUsers.new(
    :app_id => Settings.facebook_app_id, :secret => Settings.facebook_secret)
  @user = test_users.create(true, Settings.facebook_scopes)
  User.create!(
    provider: 'facebook',
    uid: @user['id'],
    name: 'Test User',
    email: 'test@test.com')
end

Quando /^eu acesso a página principal$/ do
  visit Settings.facebook_app_url
end

Dado /^que estou logado no facebook$/ do
  visit "http://www.facebook.com"
  fill_in "email", with: @user['email']
  fill_in "pass", with: @user['password']
  click_button "Log In"
end

Então /^devo ser autenticado com sucesso$/ do
  within_frame "iframe_canvas" do
    page.should have_content("Seja bem vindo!")
  end
end

Dado /^que sou um usuário não cadastrado no Votar Como Vamos$/ do
  test_users = Koala::Facebook::TestUsers.new(
    :app_id => Settings.facebook_app_id, :secret => Settings.facebook_secret)
  @user = test_users.create(false)
end

Dado /^que existe um macro-tema cadastrado$/ do
  @category = FactoryGirl.create(:category)
end

Quando /^confirmo o pedido de autorização$/ do
  within_frame "iframe_canvas" do
    find(".platform_dialog a").click
  end
  find('#grant_clicked input').click
end

Dado /^que eu sou um candidato cadastrado$/ do
  @candidate = FactoryGirl.create(:candidate)
end

Dado /^que eu estou cadastrando uma proposta$/ do
  visit new_candidate_proposal_path(@candidate)
end

Quando /^eu preencher todos os campos da proposta$/ do
  @proposal = FactoryGirl.build(:proposal,
                                :candidate => @candidate,
                                :categories => [@category])
  fill_proposal_form_with(@proposal)
end

Quando /^eu preencher os campos da proposta com dados inválidos$/ do
  @proposal = FactoryGirl.build(:invalid_proposal, :candidate => @candidate)
  fill_proposal_form_with(@proposal)
end

Entao /^eu devo ver uma mensagem de sucesso$/ do
  page.should have_selector('.alert-message.success')
end

Entao /^eu devo ver a página do candidato/ do
  current_path.should == candidate_path(@candidate)
end

Entao /^eu devo ver os campos que contêm erros$/ do
  page.should have_selector('#proposal_title + .error')
  page.should have_selector('#proposal_abstract + .error')
  page.should have_selector('#proposal_description + .error')
end

Dado /^que eu estou logado na aplicação$/ do
  @current_user = FactoryGirl.create :user
  login_with uid: @current_user.uid
end

Dado /^que existe um candidato$/ do
  @candidate = FactoryGirl.create :candidate
end

Dado /^que existe um candidato com propostas$/ do
  @candidate = FactoryGirl.create :candidate_with_proposals
end

Dado /^que o cadastro do candidato possui um e\-mail válido$/ do
  @candidate.email.should match(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i)
end

Quando /^solicitamos envio de reinvindicação de e\-mail$/ do
  Revindication.send_to_all_candidates 
end

Dado /^que existem alguns candidatos válidos$/ do
 @candidates = 3.times.map do |i|
   FactoryGirl.create :candidate, email: "candidato#{i}@tse.gov.br" 
 end
end

Quando /^solicitamos envio de reinvindicação de perfil em massa$/ do
  Revindication.send_to_all_candidates 
end

Entao /^todos os candidatos devem receber um e\-mail com a solicitação$/ do
  ActionMailer::Base.deliveries.size.should == 3

  @candidates.each do |candidate|
    open_email(candidate.email)
    current_email.should be_delivered_from("admin@votocomovamos.org.br")
    current_email.body.should =~ Regexp.new(new_candidate_ownership_path(candidate))
  end  
end

Quando /^eu acesso o perfil do mesmo$/ do
  visit candidate_path(@candidate)
end

Entao /^eu devo ver as suas informações$/ do
  [
    :alliance, :about, :email, :name, :party, :phone, :role, :tse_number
  ].each do |field|
    page.should have_content(@candidate.send(field))
  end

  [
    :blog, :facebook, :site, :twitter
  ].each do |field|
    page.should have_css("a[href='#{@candidate.send(field)}']")
  end

  page.should have_css("img[src='#{@candidate.photo}']")

  @candidate.proposals.each do |proposal|
    page.should have_content(proposal.title)
    page.should have_content(proposal.abstract)
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

Quando /^confirmo a solicitação$/ do
  within_frame "iframe_canvas" do
    click_button 'Confirmar'
  end
end

Então /^devo ver que minha solicitação foi feita$/ do
  page.should have_content("Solicitação realizada com sucesso")
end

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

def login_with(mock_options = nil)
  OmniAuth.config.test_mode = true

  if mock_options == :invalid_credentials
    OmniAuth.config.mock_auth[:facebook] = :invalid_credentials
  elsif mock_options
    OmniAuth.config.add_mock :facebook, mock_options
  end

  visit "/auth/facebook"
end

Dado /^que eu tenha uma proposta cadastrada$/ do
  @proposal = FactoryGirl.create(:proposal, :candidate => @candidate)
end

Dado /^que eu estou visualizando uma proposta$/ do
  visit candidate_proposal_path(@proposal.candidate, @proposal)
end

Quando /^eu tentar excluir a proposta$/ do
  click_on I18n.t('proposals.delete.title')
end

Quando /^eu confirmar a exclusão da proposta$/ do
  click_on I18n.t('yes')
end

Quando /^eu cancelar a exclusão da proposta$/ do
  click_on I18n.t('cancel')
end

Então /^eu devo ver a proposta$/ do
  current_path.should == candidate_proposal_path(@candidate, @proposal)
end

Dado /^que o Voto Como Vamos me enviou um e\-mail solicitando que eu administre meu peril$/ do
  @candidate = FactoryGirl.create :candidate
  Revindication.send_to_all_candidates
end

Quando /^acesso endereço de solicitação fornecido no e\-mail$/ do
  open_last_email
  visit_in_email('aqui')
end

Quando /^entro com minhas credenciais no facebook$/ do
  test_users = Koala::Facebook::TestUsers.new(
    :app_id => Settings.facebook_app_id, :secret => Settings.facebook_secret)
  @user = test_users.create(false)
  fill_in "email", with: @user['email']
  fill_in "pass", with: @user['password']
  click_button "Log In"
  find('#grant_clicked input').click  
end

Então /^devo ir para aceitação dos termos de uso$/ do
  current_url.should =~ Regexp.new(Settings.facebook_app_url + new_candidate_ownership_path(@candidate))
end

Dado /^que estou na página de solicitação de administração do meu perfil$/ do
  @candidate = FactoryGirl.create :candidate
  visit new_candidate_ownership_path(@candidate)
end

Quando /^aceito os termos de uso$/ do
  within_frame "iframe_canvas" do
    check "Aceito os Termos e Condições"
  end
end

Então /^devo poder administrar o meu perfil$/ do
  within_frame "iframe_canvas" do
    page.should have_content "Editar Candidato"
  end
end
