FactoryGirl.define do
  factory :candidate do
    name       'Candidato Fulano de Tal'
    role       'F_ROLE'
    party      'F_PARTY'
    alliance   'F_ALLIANCE'
    tse_number 'F_TSE_NUMBER'
    email      'F_EMAIL@CANDIDATO.GOV.BR'
    about      'F_ABOUT'
    phone      '(51)9999-7777'
    site       'F_SITE'
    blog       'F_BLOG'
    facebook   'F_FACEBOOK'
    twitter    'F_TWITTER'
  end
end
