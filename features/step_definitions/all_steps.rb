# -*- encoding : utf-8 -*-
WELCOME_MESSAGE = "Frase bem queridona"

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
    page.should have_content(WELCOME_MESSAGE)
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

Dado /^que eu represento o candidato$/ do
  @ownership = Ownership.create! :candidate => @candidate, :user => @user
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

Quando /^eu não preencho os campos da proposta$/ do
  @proposal = FactoryGirl.build(:invalid_proposal_missing_all_fields, :candidate => @candidate)
  fill_proposal_form_with(@proposal)
end

Quando /^eu não preencho o campo (descrição|titulo|abstract)$/ do |field|
  @proposal = FactoryGirl.build(:invalid_proposal_missing_description, :candidate => @candidate) if field == 'descrição'
  @proposal = FactoryGirl.build(:invalid_proposal_missing_abstract, :candidate => @candidate) if field == 'abstract'
  @proposal = FactoryGirl.build(:invalid_proposal_missing_title, :candidate => @candidate) if field == 'titulo'
  fill_proposal_form_with(@proposal)
end

Entao /^eu devo ver uma mensagem de sucesso$/ do
  page.should have_selector('.alert-message.success')
end

Entao /^eu devo ver a página do candidato/ do
  current_path.should == candidate_path(@candidate)
end

Entao /^eu devo ver uma mensagem informando que eu preciso preencher cada um dos três campos$/ do
  page.should have_selector('#proposal_title + .error')
  page.should have_selector('#proposal_abstract + .error')
  page.should have_selector('#proposal_description + .error')
end

Entao /^eu devo ver uma mensagem informando que o campo (descrição|abstract|titulo) é obriatório$/ do |field|
  page.should have_selector('#proposal_title + .error') if field == 'titulo'
  page.should have_selector('#proposal_abstract + .error') if field == 'abstract'
  page.should have_selector('#proposal_description + .error') if field == 'descrição'
end

Dado /^que eu estou logado na aplicação$/ do
  @user = FactoryGirl.create :user
  login_with uid: @user.uid
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
  Ownership.send_revindication_to_all_candidates 
end

Dado /^que existem alguns candidatos válidos$/ do
 @candidates = 3.times.map do |i|
   FactoryGirl.create :candidate, email: "candidato#{i}@tse.gov.br" 
 end
end

Quando /^eu preencho um (titulo|abstract|descrição) com muitos caracteres$/ do |field|
  @proposal = FactoryGirl.build(:invalid_proposal_with_big_description, :candidate => @candidate) if field == 'descrição'
  @proposal = FactoryGirl.build(:invalid_proposal_with_big_abstract, :candidate => @candidate) if field == 'abstract'
  @proposal = FactoryGirl.build(:invalid_proposal_with_big_title, :candidate => @candidate) if field == 'titulo'
  fill_proposal_form_with(@proposal)
end

Entao /^eu devo ver uma mensagem informando que o (titulo|descrição|abstract) é inválido$/ do |field|
  page.should have_selector('#proposal_title + .error') if field == 'titulo'
  page.should have_selector('#proposal_abstract + .error') if field == 'abstract'
  page.should have_selector('#proposal_description + .error') if field == 'descrição'
end

Quando /^solicitamos envio de reinvindicação de perfil em massa$/ do
  Ownership.send_revindication_to_all_candidates 
end

Entao /^todos os candidatos devem receber um e\-mail com a solicitação$/ do
  ActionMailer::Base.deliveries.size.should == 3

  @candidates.each do |candidate|
    open_email(candidate.email)
    current_email.should be_delivered_from("admin@votocomovamos.org.br")
    current_email.body.should =~ Regexp.new(new_candidate_ownership_path(candidate.reload.obfuscated_slug))
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
  visit candidates_path
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
  click_button 'Confirmar'
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

Quando /^marcar '(.*?)' no campo Assessoria de Imprensa$/ do |option|
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

Então /^ele deve ser uma mensagem informando que seu perfil é gerenciado pela assessoria de imprensa$/ do
  page.should have_content('Este perfil é gerenciado pela Assessoria de Imprensa')
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
  Ownership.send_revindication_to_all_candidates
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
  current_url.should =~ Regexp.new(Settings.facebook_app_url + new_candidate_ownership_path(@candidate.obfuscated_slug))
end

Dado /^que estou na página de solicitação de administração do meu perfil$/ do
  @candidate = FactoryGirl.create :candidate
  visit new_candidate_ownership_path(@candidate.obfuscated_slug)
end

Quando /^aceito os termos de uso$/ do
  check "Aceito os Termos e Condições"
end

Então /^devo poder administrar o meu perfil$/ do
  page.should have_content "Editar Candidato"
end

Dado /^que outro candidato tenha uma proposta cadastrada$/ do
  candidate = FactoryGirl.create :candidate
  @proposal = FactoryGirl.create :proposal, :candidate => candidate
end

Então /^eu não posso editar a proposta do outro candidato$/ do
  page.should_not have_selector "#edit_proposal"
end

Então /^eu posso editar a proposta$/ do
  page.should have_selector "#edit_proposal"
end

Quando /^eu estou visualizando uma proposta$/ do
  visit candidate_proposal_path(@proposal.candidate, @proposal)
end

Dado /^que outro candidato exista$/ do
  @another_candidate = FactoryGirl.create :candidate
end

Quando /^eu estou visualizando o perfil de outro candidato$/ do
  visit candidate_path @another_candidate
end

Então /^eu não posso editar o perfil$/ do
  page.should_not have_selector "#edit_profile"
end

Quando /^eu estou visualizando o meu perfil$/ do
  visit candidate_path @candidate
end

Então /^eu posso editar o perfil$/ do
  page.should have_selector "#edit_profile"
end

Dado /^que existem alguns candidatos que atendem ao criterio de busca$/ do
  @in_search_candidates = 3.times.map do |i|
    FactoryGirl.create :candidate, :name => "XYZ #{i}"
  end
end

Dado /^que existem alguns candidatos que não atendem ao criterio de busca$/ do
  @out_search_candidates = 3.times.map  do |i|
    FactoryGirl.create :candidate, :name => "PTW #{i}"
  end
end

Quando /^peço para listar os candidatos de acordo com o critério de busca$/ do
  Candidate.tire.index.refresh
  visit candidates_path
  fill_in "query", :with => "XYZ" 
  click_button "Buscar"
end

Então /^devo ver apenas os candidados que atendem ao criterio de busca$/ do
  @in_search_candidates.each do |candidate|
    page.should have_content candidate.name
  end
  @out_search_candidates.each do |candidate|
    page.should_not have_content candidate.name
  end
end

Dado /^que existem alguns macrotemas$/ do
  @categories = 3.times.map do |i|
    FactoryGirl.create :category, :name => "Category #{i}"
  end
end

Quando /^eu acesso a página inicial da aplicação$/ do
  visit root_path
end

Entao /^eu devo ver tais macrotemas$/ do
  @categories.each do |category|
    page.should have_content(category.name)
  end
end

Dado /^que existem algumas propostas para cada macrotema$/ do
  @in_category = @categories.shift

  @in_category_proposals = 2.times.map do |i| 
    FactoryGirl.create :proposal, :title => "In Proposal #{i}", :categories => [@in_category]
  end

  @out_category_proposals = @categories.each_with_index.map do |out_category, i|
    FactoryGirl.create :proposal, :title => "Out Proposal #{i}", :categories => [out_category]
  end
end

Dado /^que estou na página inicial da aplicação$/ do
  visit root_path
end

Quando /^eu escolho determinado macrotema$/ do
  Proposal.tire.index.refresh
  click_link @in_category.name
end

Entao /^devo ver apenas propostas naquele macrotema$/ do
  @in_category_proposals.each do |proposal|
    page.should have_content(proposal.title)
  end
  @out_category_proposals.each do |proposal|
    page.should_not have_content(proposal.title)
  end
end

Dado /^que tenho permissão para administrar meu perfil$/ do
  Ownership.create!(
    :user => @user, 
    :candidate => @candidate, 
    :terms_and_conditions => '1'
  )
end

Dado /^que existe uma proposta cadastrada$/ do
  @proposal = FactoryGirl.create :proposal
end

Quando /^peço pra visualizar a proposta$/ do
  visit proposal_path(@proposal)
end

Então /^devo ver as informações da proposta$/ do
  [:title, :abstract, :description].each do |attribute|
    page.should have_content(@proposal.send(attribute))
  end 
end
