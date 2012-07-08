# encoding: utf-8

FactoryGirl.define do
  factory :proposal do
    title       'Título'
    abstract    'Resumo'
    description 'Descrição'
    candidate
  end

  factory :invalid_proposal_missing_all_fields, :class => Proposal do
    title       ''
    abstract    ''
    description ''
    candidate
  end

  factory :invalid_proposal_missing_description, :class => Proposal do
    title       'Título'
    abstract    'Resumo'
    description ''
    candidate
  end

  factory :invalid_proposal_missing_title, :class => Proposal do
    title       ''
    abstract    'Resumo'
    description 'Descrição'
    candidate
  end
  
  factory :invalid_proposal_missing_abstract, :class => Proposal do
    title       'Título'
    abstract    ''
    description 'Descrição'
    candidate
  end

  factory :invalid_proposal_with_big_description, :class => Proposal do
    title       'Título'
    abstract    'Resumo'
    description '0' * 999999
    candidate
  end

  factory :invalid_proposal_with_big_title, :class => Proposal do
    title       '0' * 999999
    abstract    'Resumo'
    description 'Descrição'
    candidate
  end

  factory :invalid_proposal_with_big_abstract, :class => Proposal do
    title       'Título'
    abstract    '0' * 999999
    description 'Descrição'
    candidate
  end
end
