FactoryGirl.define do
  factory :candidate do
    name       'Candidato Fulano de Tal'
    short_name 'Fulano Legal'
    role       'F_ROLE'
    party      'F_PARTY'
    alliance   'F_ALLIANCE'
    tse_number 'F_TSE_NUMBER'
    email      'F_EMAIL@CANDIDATO.GOV.BR'
    about      'F_ABOUT'
    phone      '(51)9999-7777'
    site       'http://site.fulano.gov'
    blog       'http://blog.fulano.com'
    facebook   'http://facebook.com/fulano.de.tal'
    twitter    'http://twitter.com/fulaninho'
    photo      'http://divulgacand2012.tse.jus.br/divulgacand2012/mostrarFotoCandidato.action?sqCand=210000017152&codigoMunicipio=88013'
  end

  factory :candidate_with_proposals, :parent => :candidate do
    after(:build) do |candidate|
      candidate.proposals = 2.times.map { FactoryGirl.build(:proposal, :candidate => candidate) }
    end
  end

  factory :candidate_without_twitter, :parent => :candidate do
    after(:build) do |candidate|
      candidate.twitter = nil
      candidate.proposals = 2.times.map { FactoryGirl.build(:proposal, :candidate => candidate) }
    end
  end
  
  factory :candidate_without_facebook, :parent => :candidate do
    after(:build) do |candidate|
      candidate.facebook = nil
      candidate.proposals = 2.times.map { FactoryGirl.build(:proposal, :candidate => candidate) }
    end
  end
  
  factory :candidate_without_blog, :parent => :candidate do
    after(:build) do |candidate|
      candidate.blog = nil
      candidate.proposals = 2.times.map { FactoryGirl.build(:proposal, :candidate => candidate) }
    end
  end

  factory :candidate_without_site, :parent => :candidate do
    after(:build) do |candidate|
      candidate.site = nil
      candidate.proposals = 2.times.map { FactoryGirl.build(:proposal, :candidate => candidate) }
    end
  end
end
